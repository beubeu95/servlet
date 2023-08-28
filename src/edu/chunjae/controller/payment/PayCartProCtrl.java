package edu.chunjae.controller.payment;

import edu.chunjae.dto.*;
import edu.chunjae.model.*;

import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/PayCartPro.do")
public class PayCartProCtrl extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        //세션 생성
        HttpSession session = request.getSession();
        String cid = (String) session.getAttribute("sid");

        CartDAO dao = new CartDAO();
        List<CartVO> cartList = dao.getByIdCartList(cid);


        //결제 처리 리스트
        List<Payment> payList = new ArrayList<>();
        for (int i = 0; i < cartList.size(); i++) {
            Payment pay = new Payment();
            pay.setCid(cid);
            pay.setPno(cartList.get(i).getPno());
            pay.setAmount(cartList.get(i).getAmount());
            pay.setPmethod(request.getParameter("pmethod"));
            pay.setPcom(request.getParameter("pcom2"));
            pay.setCnum(request.getParameter("cnum"));
            pay.setPayprice(cartList.get(i).getPrice());
            payList.add(pay);
        }

        //출고 처리 리스트
        List<Serve> servList = new ArrayList<>();
        for (int i = 0; i < cartList.size(); i++) {
            Serve serv = new Serve();
            serv.setPno(cartList.get(i).getPno());
            serv.setAmount(cartList.get(i).getAmount());
            serv.setSprice(cartList.get(i).getPrice());
            servList.add(serv);
        }

        //배달 처리 리스트
        PaymentDAO payDAO = new PaymentDAO();
        List<Delivery> delList = new ArrayList<>();
        for (int i = 0; i < cartList.size(); i++) {
        Delivery del = new Delivery();
        del.setSno(payDAO.getSno());
        del.setCid(cid);
        del.setDaddr(request.getParameter("address1")+"<br>"+request.getParameter("address2")+"<br>"+request.getParameter("postcode"));
        del.setCustel(request.getParameter("custel"));
        delList.add(del);
        }

        //카트 삭제 리스트
        List<Cart> cartlist = new ArrayList<>();
        for (int i = 0; i < cartList.size(); i++) {
            Cart cart = new Cart();
            cart.setCartno(cartList.get(i).getCartno());
            cartlist.add(cart);
        }

        // 한번에 처리
        MultiPattern multiDAO = new MultiPattern();
        for (int i = 0; i < cartList.size(); i++) {
            int pno = multiDAO.pay(payList.get(i), servList.get(i), delList.get(i),cartlist.get(i) );
        }

        String path = request.getContextPath();
        response.sendRedirect(path + "/CartList.do");
    }
}
