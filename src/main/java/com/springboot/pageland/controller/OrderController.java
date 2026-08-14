package com.springboot.pageland.controller;

import java.time.LocalDate;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.security.core.userdetails.User;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.springboot.pageland.auth.WebSecurityConfig;
import com.springboot.pageland.dao.IBookDAO;
import com.springboot.pageland.dao.ICartDAO;
import com.springboot.pageland.dao.IMemberBooksDAO;
import com.springboot.pageland.dao.IMemberDAO;
import com.springboot.pageland.dao.IMemberPassesDAO;
import com.springboot.pageland.dao.IOrderDetailDAO;
import com.springboot.pageland.dao.IOrderListDAO;
import com.springboot.pageland.dao.IPassDAO;
import com.springboot.pageland.dto.CartDTO;
import com.springboot.pageland.dto.MemberBooksDTO;
import com.springboot.pageland.dto.MemberPassesDTO;
import com.springboot.pageland.dto.OrderDetailDTO;
import com.springboot.pageland.dto.OrderListDTO;

@Controller
public class OrderController {

    private final WebSecurityConfig webSecurityConfig;
	@Autowired
	private ICartDAO cdao;
	
	@Autowired
	private IBookDAO bdao;

	@Autowired
	private IPassDAO pdao;
	
	@Autowired
	private IMemberDAO mdao;
	
	@Autowired
	private IOrderListDAO oldao;	

	@Autowired
	private IOrderDetailDAO oddao;
	
	@Autowired
	private	IMemberBooksDAO mbdao;
	
	@Autowired
	private	IMemberPassesDAO mpdao;
	
    OrderController(WebSecurityConfig webSecurityConfig) {
        this.webSecurityConfig = webSecurityConfig;
    }
	
	// 바로 결제
	@RequestMapping("/pay/payForm")
	public String payForm(CartDTO cdto, Model model,
				@AuthenticationPrincipal User user) {
		int totalAmount;
		String prodName;
		int fee = 0;
		String buyerEmail = user.getUsername();
		
		System.out.println(cdto.getCtype());
		
		if(cdto.getCtype().equals("book")) {
			prodName = bdao.bookDetail(cdto.getBno()).getBname();
			int pprice = bdao.bookDetail(cdto.getBno()).getBprice();
			totalAmount = cdto.getCstock() * pprice;
		} else {
			prodName = pdao.passDetail(cdto.getPno()).getPname();
			int pprice = pdao.passDetail(cdto.getPno()).getPprice();
			totalAmount = cdto.getCstock() * pprice;
		}
		
		if (totalAmount < 30000) {
			fee = 8000;
			totalAmount = totalAmount + fee;
		}
		
		model.addAttribute("prodCount", 0);
		model.addAttribute("totalAmount", totalAmount);
		model.addAttribute("fee", fee);
		model.addAttribute("prodName", prodName);
		model.addAttribute("cdto", cdto);
		model.addAttribute("buyerEmail", buyerEmail);
		model.addAttribute("buyerTel", mdao.findByEmail(buyerEmail).getMtel());
		model.addAttribute("buyerName", mdao.findByEmail(buyerEmail).getMname());
		
		return "pay/payForm";
	}
	
	@RequestMapping("/pay/paySuccess")
	@ResponseBody
	public Map<String, Object> paySuccess(@RequestBody Map<String, Object> reqData,
            							@AuthenticationPrincipal User user) {
		// JS에서 보낸 JSON 데이터를 reqData.get()으로 꺼내서 사용
	    String paymentId = (String) reqData.get("paymentId");
	    String ctype = (String) reqData.get("ctype");
	    int bno = ((Number) reqData.get("bno")).intValue();
	    int pno = ((Number) reqData.get("pno")).intValue();
	    int cstock = ((Number) reqData.get("cstock")).intValue();
	    int totalAmount = ((Number) reqData.get("totalAmount")).intValue();
	    int fee = ((Number) reqData.get("fee")).intValue();
	    Integer sale = null;	// 구독권까지 적용하는 단계에서는 반드시 바꿀 것
	    int prodAmount = totalAmount - fee;
	    String payment = (String) reqData.get("payment");
	    String buyerEmail = (String) reqData.get("buyerEmail");
	    
	    Map<String, Object> result = new HashMap<>();
	    
	    // 주문 목록 등록
	    OrderListDTO oldto = new OrderListDTO();
	    oldto.setOlno(paymentId);
	    oldto.setOlprice(prodAmount);
	    oldto.setOlfee(fee);
	    oldto.setOlsale(0);
	    // oldto.setOltotal(totalAmount - sale);
	    oldto.setOltotal(totalAmount);
	    oldto.setOlpayment(payment);
	    oldto.setMno(mdao.findByEmail(buyerEmail).getMno());
	    
	    oldao.orderListInsert(oldto);
	    
	    // 주문 상세 등록
	    OrderDetailDTO oddto = new OrderDetailDTO();
	    oddto.setOdstock(cstock);
	    oddto.setOdprice(prodAmount);
	    oddto.setOdsale(0);
	    oddto.setOlno(paymentId);
	    if (ctype.equals("book")) {
	    	oddto.setBno(bno);
	    	
	    	// 회원 대여 도서 목록 등록
	    	LocalDate startDate = LocalDate.now().plusDays(4);
	    	LocalDate endDate = startDate.plusDays(cstock * 15L);
	    	
	    	MemberBooksDTO mbdto = new MemberBooksDTO();
	    	mbdto.setMbstart(startDate);
	    	mbdto.setMbend(endDate);
	    	mbdto.setMno(oldto.getMno());
	    	mbdto.setOlno(oldto.getOlno());
	    	mbdto.setBno(bno);
	    	mbdto.setMpno(null); // 나중에 구독권까지 적용하면 바꿀것
	    	
	    	mbdao.memberBooksInsert(mbdto);
	    } else {
	    	oddto.setPno(pno);
	    	
	    	// 회원 구독권 목록 등록
	    	MemberPassesDTO mpdto = new MemberPassesDTO();
	    	if ("N회권".equals(pdao.passDetail(pno).getPtype())) {
	    		mpdto.setMpcount(cstock * 10);
	    		mpdto.setMpend(null);
	    	} else if ("정기권".equals(pdao.passDetail(pno).getPtype())) {
	    		LocalDate startDate = LocalDate.now();
		    	LocalDate endDate = startDate.plusMonths(cstock * 6L);
	    		mpdto.setMpcount(null);
	    		mpdto.setMpend(endDate);
	    	}
	    	mpdto.setMno(oldto.getMno());
	    	mpdto.setOlno(oldto.getOlno());
	    	mpdto.setPno(pno);
	    	
	    	mpdao.memberPassesInsert(mpdto);
	    }
	    // 나중에 구독권까지 적용하면 바꿀것
	    oddto.setMpno(null);
	    
	    oddao.orderDetailInsert(oddto);
	    
		result.put("success", true);
	    return result;
	}
	
	// 장바구니 결제
	@RequestMapping("/pay/cartPayForm")
	public String cartPayForm(Model model, @RequestParam("cnoList") List<Integer> cnoList,
							@AuthenticationPrincipal User user) {
		List<CartDTO> payList = cdao.cartPayList(cnoList);
		
		// 선택된 상품이 없거나 비어있는 경우
	    if (payList == null || payList.isEmpty()) {
	        return "redirect:/cart/cartList";
	    }
		
		int totalAmount = 0;
		int fee = 0;
		String buyerEmail = user.getUsername();
		
		for (CartDTO cdto : payList) {
			if(cdto.getCtype().equals("book")) {
				int pprice = cdto.getBprice();
				totalAmount += cdto.getCstock() * pprice;
			} else {
				int pprice = cdto.getPprice();
				totalAmount += cdto.getCstock() * pprice;
			}
		}
		
		if (totalAmount < 30000) {
			fee = 8000;
			totalAmount = totalAmount + fee;
		}
		
		CartDTO firstItem = payList.get(0);
		String prodName = "book".equals(firstItem.getCtype()) ? firstItem.getBname() : firstItem.getPname();
		int	prodCount = payList.size() - 1;
		
		model.addAttribute("prodCount", prodCount);
		model.addAttribute("totalAmount", totalAmount);
		model.addAttribute("fee", fee);
		model.addAttribute("prodName", prodName);
		model.addAttribute("cnoList", cnoList);
		model.addAttribute("buyerEmail", buyerEmail);
		model.addAttribute("buyerTel", mdao.findByEmail(buyerEmail).getMtel());
		model.addAttribute("buyerName", mdao.findByEmail(buyerEmail).getMname());
		
		return "pay/cartPayForm";
	}
	
	@RequestMapping("/pay/cartPaySuccess")
	@ResponseBody
	public Map<String, Object> cartPaySuccess(@RequestBody Map<String, Object> reqData,
            								@AuthenticationPrincipal User user) {
		// JS에서 보낸 JSON 데이터를 reqData.get()으로 꺼내서 사용
	    String paymentId = (String) reqData.get("paymentId");
	    List<Integer> cnoList = (List<Integer>) reqData.get("cnoList");
	    List<CartDTO> payList = cdao.cartPayList(cnoList);
	    int totalAmount = ((Number) reqData.get("totalAmount")).intValue();
	    int fee = ((Number) reqData.get("fee")).intValue();
	    Integer sale = null;	// 구독권까지 적용하는 단계에서는 반드시 바꿀 것
	    int prodAmount = totalAmount - fee;
	    String payment = (String) reqData.get("payment");
	    String buyerEmail = (String) reqData.get("buyerEmail");
	    
	    Map<String, Object> result = new HashMap<>();
	    
	    // 주문 목록 등록
	    OrderListDTO oldto = new OrderListDTO();
	    oldto.setOlno(paymentId);
	    oldto.setOlprice(prodAmount);
	    oldto.setOlfee(fee);
	    oldto.setOlsale(0);
	    // oldto.setOltotal(totalAmount - sale);
	    oldto.setOltotal(totalAmount);
	    oldto.setOlpayment(payment);
	    oldto.setMno(mdao.findByEmail(buyerEmail).getMno());
	    
	    oldao.orderListInsert(oldto);
	    
	    // 주문 상세 등록
	    for (CartDTO cdto : payList) {
	    	OrderDetailDTO oddto = new OrderDetailDTO();
		    oddto.setOdstock(cdto.getCstock());
		    oddto.setOdsale(0);
		    oddto.setOlno(paymentId);
		    
		    System.out.println(cdto.getCtype());
		    
		    if ("book".equals(cdto.getCtype())) {
		    	oddto.setBno(cdto.getBno());
		    	oddto.setPno(null);
		    	oddto.setOdprice(cdto.getBprice());
		    	
		    	// 회원 대여 도서 목록 등록
		    	LocalDate startDate = LocalDate.now().plusDays(4);
		    	LocalDate endDate = startDate.plusDays(cdto.getCstock() * 15L);
		    	
		    	MemberBooksDTO mbdto = new MemberBooksDTO();
		    	mbdto.setMbstart(startDate);
		    	mbdto.setMbend(endDate);
		    	mbdto.setMno(oldto.getMno());
		    	mbdto.setOlno(oldto.getOlno());
		    	mbdto.setBno(cdto.getBno());
		    	mbdto.setMpno(null); // 나중에 구독권까지 적용하면 바꿀것
		    	
		    	mbdao.memberBooksInsert(mbdto);
		    } else if ("pass".equals(cdto.getCtype())) {
		    	oddto.setPno(cdto.getPno());
		    	oddto.setBno(null);
		    	oddto.setOdprice(cdto.getPprice());
		    	
		    	// 회원 구독권 목록 등록
		    	MemberPassesDTO mpdto = new MemberPassesDTO();
		    	if ("N회권".equals(pdao.passDetail(cdto.getPno()).getPtype())) {
		    		mpdto.setMpcount(cdto.getCstock() * 10);
		    		mpdto.setMpend(null);
		    	} else if ("정기권".equals(pdao.passDetail(cdto.getPno()).getPtype())) {
		    		LocalDate startDate = LocalDate.now();
			    	LocalDate endDate = startDate.plusMonths(cdto.getCstock() * 6L);
		    		mpdto.setMpcount(null);
		    		mpdto.setMpend(endDate);
		    	}
		    	mpdto.setMno(oldto.getMno());
		    	mpdto.setOlno(oldto.getOlno());
		    	mpdto.setPno(cdto.getPno());
		    	
		    	mpdao.memberPassesInsert(mpdto);
		    }
		    // 나중에 구독권까지 적용하면 바꿀것
		    oddto.setMpno(null);
		    
		    oddao.orderDetailInsert(oddto);
		    cdao.cartDelete(cdto.getCno());
	    }
	    
		result.put("success", true);
	    return result;
	}
	
	@RequestMapping("/pay/payResult")
	public String payResult(@RequestParam("paymentId") String paymentId, 
							Model model) {
		model.addAttribute("paymentId", paymentId);
		
		return "pay/paySuccess";
	}
	
	@RequestMapping("/member/orderList")
	public String orderList(Model model,
							@AuthenticationPrincipal User user) {
		int mno = mdao.findByEmail(user.getUsername()).getMno();
		
		model.addAttribute("orders", oldao.morderList(mno));
		
		return "member/orderList";
	}
}
