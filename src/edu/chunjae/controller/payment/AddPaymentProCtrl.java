package edu.chunjae.controller.payment;

import edu.chunjae.dto.Delivery;
import edu.chunjae.dto.Payment;
import edu.chunjae.dto.Serve;
import edu.chunjae.model.CartDAO;
import edu.chunjae.model.DeliveryDAO;
import edu.chunjae.model.PaymentDAO;

import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.io.PrintWriter;

@WebServlet("/AddPaymentPro.do")
public class AddPaymentProCtrl extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        //결제 처리(paymentDAO.addPayment(Payment pay))
        Payment pay = new Payment();
        pay.setCid(request.getParameter("cid"));
        pay.setPno(Integer.parseInt(request.getParameter("Pno")));
        pay.setAmount(Integer.parseInt(request.getParameter("amount")));
        pay.setPmethod(request.getParameter("pmethod"));
        pay.setPcom(request.getParameter("pcom"));
        pay.setCnum(request.getParameter("cnum"));
        pay.setPayprice(Integer.parseInt(request.getParameter("payprice")));

        PaymentDAO payDAO = new PaymentDAO();
        int cnt1 = payDAO.addPayment(pay);

        //출고 처리(PaymentDAO.addServe(serv))
        Serve serv = new Serve();
        serv.setPno(Integer.parseInt(request.getParameter("pno")));
        serv.setAmount(Integer.parseInt(request.getParameter("amount")));
        serv.setSprice(Integer.parseInt(request.getParameter("sprice")));

        int cnt2 = payDAO.addServe(serv);


        //배송 등록(DeliveryDAO.addDelivery(del))
        Delivery del = new Delivery();
        del.setSno(payDAO.getSno());
        del.setCid(request.getParameter("cid"));
        del.setDaddr(request.getParameter("address1")+"<br>"+request.getParameter("address2")+"<br>"+request.getParameter("postcode"));
        del.setCustel(request.getParameter("custel"));

        DeliveryDAO deliDAO = new DeliveryDAO();
        int cnt3 = deliDAO.addDelivery(del);

        //쇼핑카트에서 결제한 정보라면 (CartDAO.delCart(cartno));

        CartDAO cartDAO = new CartDAO();
        String from = request.getParameter("from");
        int cartno = 0;
        int cnt4 = 0;
        if(from.equals("cart")){
            cartno = Integer.parseInt(request.getParameter("cartno"));
            cnt4 = cartDAO.delCart(cartno);
        }

        int pno = Integer.parseInt(request.getParameter("pno"));
        PrintWriter out = response.getWriter();

        if(cnt1 > 0 && cnt2 > 0 && cnt3 > 0){
            response.sendRedirect(request.getContextPath()+"/ProList.do");
        } else {
            response.sendRedirect(request.getContextPath()+"/AddPayment.do?pno="+pno);
        }
    }
}
