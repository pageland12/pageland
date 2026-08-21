package com.springboot.pageland.controller;

import java.time.LocalDate;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.User;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.springboot.pageland.auth.WebSecurityConfig;
import com.springboot.pageland.dao.IBookDAO;
import com.springboot.pageland.dao.ICartDAO;
import com.springboot.pageland.dao.IMemberBooksDAO;
import com.springboot.pageland.dao.IMemberDAO;
import com.springboot.pageland.dao.IMemberPassesDAO;
import com.springboot.pageland.dao.IOrderDetailDAO;
import com.springboot.pageland.dao.IOrderListDAO;
import com.springboot.pageland.dao.IPassDAO;
import com.springboot.pageland.dto.BookDTO;
import com.springboot.pageland.dto.CartDTO;
import com.springboot.pageland.dto.MemberBooksDTO;
import com.springboot.pageland.dto.MemberDTO;
import com.springboot.pageland.dto.MemberPassesDTO;
import com.springboot.pageland.dto.OrderDetailDTO;
import com.springboot.pageland.dto.OrderListDTO;
import com.springboot.pageland.dto.PassDTO;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

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
	
    // Spring Security 세션의 권한을 즉시 갱신하는 메서드
    private void refreshUserAuthentication(String role, HttpServletRequest request) {
        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        if (auth != null) {
            // 1. 새로운 권한 생성
            List<GrantedAuthority> updatedAuthorities = new ArrayList<>();
            updatedAuthorities.add(new SimpleGrantedAuthority("ROLE_" + role));

            // 2. UserDetails(User) 객체도 새로운 권한을 가진 새 객체로 재생성
            String username = auth.getName(); // 사용자 이메일/아이디
            String password = auth.getCredentials() != null ? auth.getCredentials().toString() : "";
            User newUserPrincipal = new User(username, password, updatedAuthorities);

            // 3. 새로운 Authentication 토큰 생성
            Authentication newAuth = new UsernamePasswordAuthenticationToken(
                newUserPrincipal,
                auth.getCredentials(),
                updatedAuthorities
            );
            
            // 4. SecurityContext 및 세션 강제 동기화
            SecurityContextHolder.getContext().setAuthentication(newAuth);
            
            if (request != null) {
            	HttpSession session = request.getSession(false);
            	if (session != null) {
            		session.setAttribute("SPRING_SECURITY_CONTEXT", SecurityContextHolder.getContext());
            	}
            }
        }
    }
    
	// 바로 결제
	@RequestMapping("/pay/payForm")
	public String payForm(CartDTO cdto, Model model,
						  @AuthenticationPrincipal User user,
						  RedirectAttributes rttr) {
		int totalAmount;
		String prodName;
		int fee = 0;
		String buyerEmail = user.getUsername();
		int mno = mdao.findByEmail(buyerEmail).getMno();
		
		if ("book".equalsIgnoreCase(cdto.getCtype()) || (cdto.getBno() != null && cdto.getBno() > 0)) {
			// 현재 연체 중인 도서가 있으면 바로 결제 X
			if (mbdao.overdueBooksCount(mno) > 0) {
				rttr.addFlashAttribute("msg", "현재 연체 중인 도서가 있습니다. 연체료 정산 및 반납 후 이용해 주세요.");
				return "redirect:/guest/bookDetail?bno=" + cdto.getBno();
			}
			
			// 이미 대여 중인 도서는 바로 결제 X
			MemberBooksDTO rentCheck = new MemberBooksDTO();
			rentCheck.setMno(mno);
			rentCheck.setBno(cdto.getBno());
			if (mbdao.memberBooksDetail(rentCheck) != null) {
				rttr.addFlashAttribute("msg", "이미 대여 중이거나 대여 진행 중인 도서입니다.");
				return "redirect:/guest/bookDetail?bno=" + cdto.getBno();
			}
			
			// 대여 권수 3권이면 결제 X
	        if (mbdao.activeRentBooksCount(mno) >= 3) {
	            rttr.addFlashAttribute("msg", "동시 대여는 최대 3권까지만 가능합니다.");
	            return "redirect:/guest/bookDetail?bno=" + cdto.getBno();
	        }
		}
		
		// 현재 회원이 정기권 구독자인지 확인
	    boolean isSubscriber = user.getAuthorities().stream()
	            .anyMatch(a -> a.getAuthority().equals("ROLE_SUBSCRIBER"));
	    
	    int originalPrice = 0;
	    int sale = 0;
		
		if(cdto.getCtype().equalsIgnoreCase("book")) {
			
			prodName = bdao.bookDetail(cdto.getBno()).getBname();
			int pprice = bdao.bookDetail(cdto.getBno()).getBprice();
			originalPrice = cdto.getCstock() * pprice;
			
			// 정기권 회원은 모든 가격 0
			if (isSubscriber) {
				sale = originalPrice;
	            fee = 0;
	            totalAmount = 0;
			} else {
				if (originalPrice < 30000) {
					fee = 8000;
				}
				totalAmount = originalPrice + fee;
			}
		} else {
			prodName = pdao.passDetail(cdto.getPno()).getPname();
			int pprice = pdao.passDetail(cdto.getPno()).getPprice();
			originalPrice = cdto.getCstock() * pprice;
			
			if (originalPrice < 30000) {
				fee = 8000;
			}
			totalAmount = originalPrice + fee;
		}
		
		model.addAttribute("prodCount", 0);
		model.addAttribute("prodAmount", originalPrice);
		model.addAttribute("totalAmount", totalAmount);
		model.addAttribute("sale", sale);
		model.addAttribute("fee", fee);
		model.addAttribute("prodName", prodName);
		model.addAttribute("cdto", cdto);
		model.addAttribute("buyerEmail", buyerEmail);
		model.addAttribute("buyerTel", mdao.findByEmail(buyerEmail).getMtel());
		model.addAttribute("buyerName", mdao.findByEmail(buyerEmail).getMname());
		
		return "pay/payForm";
	}
	
	// 구독권 사용 x
	@RequestMapping("/pay/paySuccess")
	@ResponseBody
	public Map<String, Object> paySuccess(@RequestBody Map<String, Object> reqData,
            							@AuthenticationPrincipal User user, 
            							HttpServletRequest request) {
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
	    	
	    	bdao.bookStockDecrease(bno);
	    	
	    	mbdao.memberBooksInsert(mbdto);
	    	
	    	// 바로 결제 이후 장바구니에 담겨져 있는 목록 삭제
	    	if ("book".equalsIgnoreCase(ctype) && bno > 0) {
	    		CartDTO cartCheck = new CartDTO();
	    		cartCheck.setMno(oldto.getMno());
	    		cartCheck.setBno(bno);
	    		cdao.cartBookDelete(cartCheck);
	    	}
	    } else {
	    	oddto.setPno(pno);
	    	PassDTO pass = pdao.passDetail(pno);
	    	
	    	// 회원 구독권 목록 등록
	    	MemberPassesDTO mpdto = new MemberPassesDTO();
	    	if ("N회권".equals(pdao.passDetail(pno).getPtype())) {
	    		MemberPassesDTO activePass = mpdao.findActiveNPass(oldto.getMno());
	    		int addCounts = cstock * pass.getPcount();
	    		if (activePass != null) {
	    			activePass.setMpcount(activePass.getMpcount() + addCounts);
	    			mpdao.nPassIncrease(activePass);
	    		} else {
	    			mpdto.setMpcount(addCounts);
		    		mpdto.setMpend(null);
		    		
		    		mpdto.setMno(oldto.getMno());
			    	mpdto.setOlno(oldto.getOlno());
			    	mpdto.setPno(pno);
			    	
			    	mpdao.memberPassesInsert(mpdto);
	    		}
	    	} else if ("정기권".equals(pdao.passDetail(pno).getPtype())) {
	    		MemberPassesDTO activePass = mpdao.findActiveSubscriberPass(oldto.getMno());
	    		long addDays = pass.getPperiod() * cstock;
	    		if (activePass != null) {
	    			activePass.setMpend(activePass.getMpend().plusDays(addDays));
	    			mpdao.subscriberPassExtend(activePass);
	    		} else {
	    			LocalDate startDate = LocalDate.now();
			    	LocalDate endDate = startDate.plusDays(addDays);
		    		mpdto.setMpcount(null);
		    		mpdto.setMpend(endDate);
		    		
		    		MemberDTO mdto = new MemberDTO();
		    		mdto.setMno(oldto.getMno());
		    		mdto.setMgrade("SUBSCRIBER");
		    		
		    		mdao.memberGradeUpdate(mdto);
		    		refreshUserAuthentication("SUBSCRIBER", request);
		    		
		    		mpdto.setMno(oldto.getMno());
			    	mpdto.setOlno(oldto.getOlno());
			    	mpdto.setPno(pno);
			    	
			    	mpdao.memberPassesInsert(mpdto);
	    		}
	    	}
	    }
	    oddto.setMpno(null);
	    
	    oddao.orderDetailInsert(oddto);
	    
		result.put("success", true);
	    return result;
	}
	
	// 구독권 사용 O
	@RequestMapping("/pay/subscriberRent")
	@ResponseBody
	public Map<String, Object> subscriberRent(@RequestBody Map<String, Object> reqData,
            							@AuthenticationPrincipal User user) {
		String buyerEmail = (String) reqData.get("buyerEmail");
	    
	    Map<String, Object> result = new HashMap<>();
	    
	    MemberDTO mdto = mdao.findByEmail(buyerEmail);
	    int mno = mdto.getMno();
	    
	    Integer mpno = mpdao.findActiveSubscriberPass(mno).getMpno();
	    if (mpno == null) {
	        result.put("success", false);
	        result.put("message", "유효한 정기권이 없습니다.");
	        return result;
	    }
	    
	    int bno = ((Number) reqData.get("bno")).intValue();
	    int cstock = reqData.get("cstock") != null ? ((Number) reqData.get("cstock")).intValue() : 1;
	    
	    BookDTO book = bdao.bookDetail(bno);
	    int originalPrice = book.getBprice() * cstock;
	    
	    // 주문 고유 번호 생성
	    String paymentId = "SUB-" + new Date().getTime();
	    
	    // 주문 목록 등록
	    OrderListDTO oldto = new OrderListDTO();
	    oldto.setOlno(paymentId);
	    oldto.setOlprice(originalPrice);
	    oldto.setOlfee(0);
	    oldto.setOlsale(originalPrice);
	    oldto.setOltotal(0);
	    oldto.setOlpayment("정기권");
	    oldto.setMno(mno);
	    
	    oldao.orderListInsert(oldto);
	    
	    // 주문 상세 등록
	    OrderDetailDTO oddto = new OrderDetailDTO();
	    oddto.setOdstock(cstock);
	    oddto.setOdprice(originalPrice);
	    oddto.setOdsale(originalPrice);
	    oddto.setOlno(paymentId);
	    oddto.setMpno(mpno);
	    oddto.setBno(bno);
	    oddto.setPno(null);
	    
	    oddao.orderDetailInsert(oddto);
    	
    	
    	// 회원 대여 도서 목록 등록
    	LocalDate startDate = LocalDate.now().plusDays(4);
    	LocalDate endDate = startDate.plusDays(cstock * 15L);
    	
    	MemberBooksDTO mbdto = new MemberBooksDTO();
    	mbdto.setMbstart(startDate);
    	mbdto.setMbend(endDate);
    	mbdto.setMno(mno);
    	mbdto.setOlno(paymentId);
    	mbdto.setBno(bno);
    	mbdto.setMpno(mpno);
    	
    	bdao.bookStockDecrease(bno);
    	
    	mbdao.memberBooksInsert(mbdto);
    	
    	CartDTO cartCheck = new CartDTO();
		cartCheck.setMno(oldto.getMno());
		cartCheck.setBno(bno);
		cdao.cartBookDelete(cartCheck);
	    
		result.put("success", true);
		result.put("paymentId", paymentId);
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
		
	    boolean isSubscriber = user.getAuthorities().stream()
	            .anyMatch(a -> a.getAuthority().equals("ROLE_SUBSCRIBER"));
	    
		int totalAmount = 0;
		int prodAmount = 0;
		int sale = 0;
		int fee = 0;
		String buyerEmail = user.getUsername();
		
		for (CartDTO cdto : payList) {
			if(cdto.getCtype().equals("book")) {
				int pprice = cdto.getBprice() * cdto.getCstock();
				prodAmount += pprice;
				if (isSubscriber) {
					sale += pprice;
				}
			} else {
				prodAmount += cdto.getCstock() * cdto.getPprice();
			}
		}
		
		int payProdAmount = prodAmount - sale;
		
		// payProdAmount = 0: 구독권으로 도서만 대여한 경우
		if (payProdAmount > 0 && payProdAmount < 30000) {
			fee = 8000;
		}
		totalAmount = payProdAmount + fee;
		
		CartDTO firstItem = payList.get(0);
		String prodName = "book".equals(firstItem.getCtype()) ? firstItem.getBname() : firstItem.getPname();
		int	prodCount = payList.size() - 1;
		
		model.addAttribute("prodCount", prodCount);
		model.addAttribute("prodAmount", prodAmount);
		model.addAttribute("totalAmount", totalAmount);
		model.addAttribute("sale", sale);
		model.addAttribute("fee", fee);
		model.addAttribute("prodName", prodName);
		model.addAttribute("cnoList", cnoList);
		model.addAttribute("buyerEmail", buyerEmail);
		model.addAttribute("buyerTel", mdao.findByEmail(buyerEmail).getMtel());
		model.addAttribute("buyerName", mdao.findByEmail(buyerEmail).getMname());
		
		return "pay/cartPayForm";
	}
	
	// 전체 구독권 결제 X
	@Transactional
	@RequestMapping("/pay/cartPaySuccess")
	@ResponseBody
	public Map<String, Object> cartPaySuccess(@RequestBody Map<String, Object> reqData,
            								@AuthenticationPrincipal User user, 
            								HttpServletRequest request) {
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
	    
	    MemberDTO member = mdao.findByEmail(buyerEmail);
	    int mno = member.getMno();
	    
	    boolean isSubscriber = user.getAuthorities().stream()
	            .anyMatch(a -> a.getAuthority().equals("ROLE_SUBSCRIBER"));
	    
	    MemberPassesDTO activePass = isSubscriber ? mpdao.findActiveSubscriberPass(mno) : null;
	    
	    int totalPrice = 0;
	    int totalSale = 0;
	    
	    for (CartDTO cdto : payList) {
	        if ("book".equals(cdto.getCtype())) {
	            int bookPrice = cdto.getBprice() * cdto.getCstock();
	            totalPrice += bookPrice;
	            if (isSubscriber) {
	                totalSale += bookPrice; // 정기권 회원은 도서 금액 전액 할인
	            }
	        } else {
	            totalPrice += cdto.getPprice() * cdto.getCstock();
	        }
	    }
	    
	    // 주문 목록 등록
	    OrderListDTO oldto = new OrderListDTO();
	    oldto.setOlno(paymentId);
	    oldto.setOlprice(totalPrice);
	    oldto.setOlfee(fee);
	    oldto.setOlsale(totalSale);
	    oldto.setOltotal(totalAmount);
	    oldto.setOlpayment(payment);
	    oldto.setMno(mno);
	    
	    oldao.orderListInsert(oldto);
	    
	    // 주문 상세 등록
	    for (CartDTO cdto : payList) {
	    	OrderDetailDTO oddto = new OrderDetailDTO();
		    oddto.setOdstock(cdto.getCstock());
		    oddto.setOlno(paymentId);
		    
		    System.out.println(cdto.getCtype());
		    
		    if ("book".equals(cdto.getCtype())) {
		    	int bookPrice = cdto.getCstock() * cdto.getBprice();
		    	int salePrice = isSubscriber ? bookPrice : 0;
		    	Integer bookMpno = (isSubscriber && activePass != null) ? activePass.getMpno() : null;
		    	
		    	oddto.setBno(cdto.getBno());
		    	oddto.setPno(null);
		    	oddto.setOdprice(bookPrice);
		    	oddto.setOdsale(salePrice);
		    	oddto.setMpno(bookMpno);

			    oddao.orderDetailInsert(oddto);
			    
		    	// 회원 대여 도서 목록 등록
		    	LocalDate startDate = LocalDate.now().plusDays(4);
		    	LocalDate endDate = startDate.plusDays(cdto.getCstock() * 15L);
		    	
		    	MemberBooksDTO mbdto = new MemberBooksDTO();
		    	mbdto.setMbstart(startDate);
		    	mbdto.setMbend(endDate);
		    	mbdto.setMno(oldto.getMno());
		    	mbdto.setOlno(oldto.getOlno());
		    	mbdto.setBno(cdto.getBno());
		    	mbdto.setMpno(bookMpno);
		    	
		    	bdao.bookStockDecrease(cdto.getBno());
		    	
		    	mbdao.memberBooksInsert(mbdto);
		    } else if ("pass".equals(cdto.getCtype())) {
		    	int passPrice = cdto.getPprice() * cdto.getCstock();
		    	
		    	oddto.setOdsale(0);
		    	oddto.setPno(cdto.getPno());
		    	oddto.setBno(null);
		    	oddto.setOdprice(passPrice);
		    	oddto.setMpno(null);
		    	
			    oddao.orderDetailInsert(oddto);
			    
			    int pno = cdto.getPno();
			    PassDTO pass = pdao.passDetail(cdto.getPno());
		    	
		    	// 회원 구독권 목록 등록
			    MemberPassesDTO mpdto = new MemberPassesDTO();
		    	if ("N회권".equals(pdao.passDetail(pno).getPtype())) {
		    		int addCounts = pass.getPcount() * cdto.getCstock();
		    		MemberPassesDTO activeNPass = mpdao.findActiveNPass(mno);
		    		// 만약 활성화된 N회권이 있으면 회수 추가
		    		if (activeNPass != null) {
		    			activeNPass.setMpcount(activeNPass.getMpcount() + addCounts);
		    			mpdao.nPassIncrease(activeNPass);
		    		} else {
		    			mpdto.setMpcount(addCounts);
			    		mpdto.setMpend(null);
			    		
			    		mpdto.setMno(oldto.getMno());
				    	mpdto.setOlno(oldto.getOlno());
				    	mpdto.setPno(pno);
				    	
				    	mpdao.memberPassesInsert(mpdto);
		    		}
		    	} else if ("정기권".equals(pdao.passDetail(pno).getPtype())) {
		    		long addDays = pass.getPperiod() * cdto.getCstock();
		    		// 만약 활성화된 정기권이 있으면 연장
		    		if (activePass != null) {
		    			activePass.setMpend(activePass.getMpend().plusDays(addDays));
		    			mpdao.subscriberPassExtend(activePass);
		    		} else {
		    			LocalDate startDate = LocalDate.now();
				    	LocalDate endDate = startDate.plusDays(addDays);
			    		mpdto.setMpcount(null);
			    		mpdto.setMpend(endDate);
			    		
			    		MemberDTO mdto = new MemberDTO();
			    		mdto.setMno(oldto.getMno());
			    		mdto.setMgrade("SUBSCRIBER");
			    		
			    		mdao.memberGradeUpdate(mdto);
			    		refreshUserAuthentication("SUBSCRIBER", request);
			    		
			    		mpdto.setMno(oldto.getMno());
				    	mpdto.setOlno(oldto.getOlno());
				    	mpdto.setPno(pno);
				    	
				    	mpdao.memberPassesInsert(mpdto);
		    		}
		    	}
		    }
		    
		    cdao.cartDelete(cdto.getCno());
	    }
	    
		result.put("success", true);
	    return result;
	}
	
	// 전체 구독권 결제 O
	@Transactional
	@RequestMapping("/pay/subscriberCartRent")
	@ResponseBody
	public Map<String, Object> subscribeCartRent(@RequestBody Map<String, Object> reqData,
	                                             @AuthenticationPrincipal User user) {
	    Map<String, Object> result = new HashMap<>();

	    String buyerEmail = user.getUsername();
	    MemberDTO member = mdao.findByEmail(buyerEmail);
	    int mno = member.getMno();

	    Integer mpno = mpdao.findActiveSubscriberPass(mno).getMpno();
	    if (mpno == null) {
	        result.put("success", false);
	        result.put("message", "유효한 정기권이 없습니다.");
	        return result;
	    }

	    List<Integer> cnoList = (List<Integer>) reqData.get("cnoList");
	    List<CartDTO> payList = cdao.cartPayList(cnoList);

	    int totalBookPrice = 0;
	    for (CartDTO cdto : payList) {
	        if ("book".equals(cdto.getCtype())) {
	            totalBookPrice += cdto.getBprice() * cdto.getCstock();
	        }
	    }

	    String paymentId = "SUB-" + new Date().getTime();

	    // 2. ORDER_LIST 등록 (0원 결제)
	    OrderListDTO oldto = new OrderListDTO();
	    oldto.setOlno(paymentId);
	    oldto.setOlprice(totalBookPrice);  // 전체 정가
	    oldto.setOlfee(0);                 // 정기권 무료 배송
	    oldto.setOlsale(totalBookPrice);   // 전액 할인
	    oldto.setOltotal(0);               // 실결제 금액 0원
	    oldto.setOlpayment("정기권");
	    oldto.setMno(mno);
	    
	    oldao.orderListInsert(oldto);

	    // 3. 각 도서별 ORDER_DETAIL, MEMBER_BOOKS 등록, 재고 차감 및 장바구니 삭제
	    for (CartDTO cdto : payList) {
	        if ("book".equals(cdto.getCtype())) {
	            int bookPrice = cdto.getBprice() * cdto.getCstock();

	            // 주문 상세 등록
	            OrderDetailDTO oddto = new OrderDetailDTO();
	            oddto.setBno(cdto.getBno());
	            oddto.setOdstock(cdto.getCstock());
	            oddto.setOdprice(bookPrice);
	            oddto.setOdsale(bookPrice);
	            oddto.setOlno(paymentId);
	            oddto.setMpno(mpno);
	            
	            oddao.orderDetailInsert(oddto);

	            // 대여 도서 등록
	            LocalDate startDate = LocalDate.now().plusDays(4);
	            LocalDate endDate = startDate.plusDays(cdto.getCstock() * 15L);

	            MemberBooksDTO mbdto = new MemberBooksDTO();
	            mbdto.setMbstart(startDate);
	            mbdto.setMbend(endDate);
	            mbdto.setMno(mno);
	            mbdto.setOlno(paymentId);
	            mbdto.setBno(cdto.getBno());
	            mbdto.setMpno(mpno);
	            
	            mbdao.memberBooksInsert(mbdto);

	            // 재고 차감 및 장바구니 삭제
	            bdao.bookStockDecrease(cdto.getBno());
	            cdao.cartDelete(cdto.getCno());
	        }
	    }

	    result.put("success", true);
	    result.put("paymentId", paymentId);
	    return result;
	}
	
	// 도서 대여 연장 결제
	@RequestMapping("/pay/extensionPayForm")
	public String extensionPayForm(CartDTO cdto, Model model,
				@AuthenticationPrincipal User user,
				@RequestParam("mbno") int mbno) {
		int totalAmount;
		String prodName;
		String buyerEmail = user.getUsername();
		
		System.out.println(cdto.getCtype());
		
		prodName = bdao.bookDetail(cdto.getBno()).getBname();
		int pprice = bdao.bookDetail(cdto.getBno()).getBprice();
		totalAmount = cdto.getCstock() * pprice;
		
		model.addAttribute("totalAmount", totalAmount);
		model.addAttribute("prodName", prodName);
		model.addAttribute("cdto", cdto);
		model.addAttribute("buyerEmail", buyerEmail);
		model.addAttribute("buyerTel", mdao.findByEmail(buyerEmail).getMtel());
		model.addAttribute("buyerName", mdao.findByEmail(buyerEmail).getMname());
		model.addAttribute("mbno", mbno);
		
		return "pay/extensionPayForm";
	}
	
	@RequestMapping("/pay/extensionPaySuccess")
	@ResponseBody
	public Map<String, Object> extensionPaySuccess(@RequestBody Map<String, Object> reqData,
            									   @AuthenticationPrincipal User user) {
		// JS에서 보낸 JSON 데이터를 reqData.get()으로 꺼내서 사용
	    String paymentId = (String) reqData.get("paymentId");
	    String ctype = (String) reqData.get("ctype");
	    int bno = ((Number) reqData.get("bno")).intValue();
	    int cstock = ((Number) reqData.get("cstock")).intValue();
	    int totalAmount = ((Number) reqData.get("totalAmount")).intValue();
	    int fee = 0;
	    Integer sale = null;	// 구독권까지 적용하는 단계에서는 반드시 바꿀 것
	    int prodAmount = totalAmount - fee;
	    String payment = (String) reqData.get("payment");
	    String buyerEmail = (String) reqData.get("buyerEmail");
	    int mbno = ((Number) reqData.get("mbno")).intValue();
	    
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
	    
	    oddto.setBno(bno);
	    
	    oddao.orderDetailInsert(oddto);
    	
    	// 회원 대여 도서 업데이트(연장)
	    int extendDays = cstock * 15;
    	mbdao.memberBookExtend(mbno, extendDays);
	    
	    oddto.setMpno(null);
	    
		result.put("success", true);
	    return result;
	}
	
	@RequestMapping("/pay/payResult")
	public String payResult(@RequestParam("paymentId") String paymentId, 
							Model model) {
		model.addAttribute("paymentId", paymentId);
		
		return "pay/paySuccess";
	}
	
	// 정기권 구독자 전용 도서 대여 연장
	@RequestMapping("/pay/extendBookFree")
	public String extendBookFree(@RequestParam("mbno") int mbno,
								 @RequestParam("cstock") int cstock,
	                             @AuthenticationPrincipal User user,
	                             RedirectAttributes rttr) {
		MemberDTO mdto = mdao.findByEmail(user.getUsername());
		
		if (!"SUBSCRIBER".equalsIgnoreCase(mdto.getMgrade())) {
	        rttr.addFlashAttribute("msg", "정기 구독 회원만 무료 연장이 가능합니다.");
	        return "redirect:/member/myBookList";
	    }
		
		// 현재 연체 중인 도서가 있으면 바로 결제 X
		if (mbdao.overdueBooksCount(mdto.getMno()) > 0) {
			rttr.addFlashAttribute("msg", "현재 연체 중인 도서가 있습니다. 연체료 정산 및 반납 후 이용해 주세요.");
			return "redirect:/member/myBookList";
		}
		
		int extendDays = cstock * 15;
    	mbdao.memberBookExtend(mbno, extendDays);
	    
    	rttr.addFlashAttribute("msg", "도서 대여 기간이 " + extendDays + "일 무료 연장되었습니다.");
		return "redirect:/member/myBookList";
	}
	
	// 반납시 연체로 납부
	@RequestMapping("/pay/lateFeePayForm")
	public String lateFeePayForm(CartDTO cdto, Model model,
								 @AuthenticationPrincipal User user,
								 @RequestParam("mbno") int mbno,
								 @RequestParam("mblatefee") int mblatefee) {
		String prodName = bdao.bookDetail(cdto.getBno()).getBname() + " (연체료)";
		String buyerEmail = user.getUsername();
		MemberDTO mdto = mdao.findByEmail(buyerEmail);
		
		model.addAttribute("totalAmount", mblatefee);
		model.addAttribute("prodName", prodName);
		model.addAttribute("cdto", cdto);
		model.addAttribute("buyerEmail", buyerEmail);
		model.addAttribute("buyerTel", mdto.getMtel());
		model.addAttribute("buyerName", mdto.getMname());
		model.addAttribute("mbno", mbno);
		
		return "pay/lateFeePayForm";
	}
	
	@Transactional
	@RequestMapping("/pay/lateFeePaySuccess")
	@ResponseBody
	public Map<String, Object> lateFeePaySuccess(@RequestBody Map<String, Object> reqData,
            									 @AuthenticationPrincipal User user) {
		// JS에서 보낸 JSON 데이터를 reqData.get()으로 꺼내서 사용
	    String paymentId = (String) reqData.get("paymentId");
	    String ctype = "book";
	    int bno = ((Number) reqData.get("bno")).intValue();
	    int cstock = 0;
	    int totalAmount = ((Number) reqData.get("totalAmount")).intValue();
	    int fee = 0;
	    Integer sale = null;
	    int prodAmount = totalAmount - fee;
	    String payment = (String) reqData.get("payment");
	    String buyerEmail = (String) reqData.get("buyerEmail");
	    int mbno = ((Number) reqData.get("mbno")).intValue();
	    
	    Map<String, Object> result = new HashMap<>();
	    
	    // 주문 목록 등록
	    OrderListDTO oldto = new OrderListDTO();
	    oldto.setOlno(paymentId);
	    oldto.setOlprice(prodAmount);
	    oldto.setOlfee(fee);
	    oldto.setOlsale(0);
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
	    
	    oddto.setBno(bno);
	    
	    oddao.orderDetailInsert(oddto);
    	
    	// 도서 반납
	    int mno = mdao.findByEmail(buyerEmail).getMno();
		
	    MemberBooksDTO mbdto = new MemberBooksDTO();
	    mbdto.setMno(mno);
	    mbdto.setBno(bno);
	    mbdto.setMbno(mbno);
	    
		
		mbdao.memberBooksReturn(mbdto);
		bdao.bookStockIncrease(mbdto.getBno());
	    
		result.put("success", true);
	    return result;
	}
	
	@RequestMapping("/pay/lateFeePayResult")
	public String lateFeePayResult(@RequestParam("paymentId") String paymentId, 
								   Model model) {
	model.addAttribute("paymentId", paymentId);
	
	return "pay/lateFeePaySuccess";
	}
	
	@RequestMapping("/member/orderList")
	public String orderList(Model model,
							@AuthenticationPrincipal User user,
							@RequestParam(value = "pageNum", defaultValue = "1") int pageNum) {
		int mno = mdao.findByEmail(user.getUsername()).getMno();
		
		int amount = 5; // 한 페이지당 5개
	    
	    int startRow = (pageNum - 1) * amount + 1;
	    int endRow = pageNum * amount;
	    
	    List<OrderListDTO> orders = oldao.memberOrderListPaging(mno, startRow, endRow);
	    int total = oldao.getTotalOrderCountByMno(mno);
	    int totalPages = (int) Math.ceil((double) total / amount);
	    
	    // --- 화면에 보여줄 페이지 번호 개수 (최대 5개) ---
	    int navSize = 5;
	    int startPage = ((pageNum - 1) / navSize) * navSize + 1;
	    int endPage = startPage + navSize - 1;
	    
	    // 실제 총 페이지 수를 넘지 않도록 조정
	    if (endPage > totalPages) {
	        endPage = totalPages;
	    }
		
		model.addAttribute("orders", orders);
	    model.addAttribute("pageNum", pageNum);
	    model.addAttribute("startPage", startPage);
	    model.addAttribute("endPage", endPage);
	    model.addAttribute("totalPages", totalPages);
		
		return "member/orderList";
	}
}
