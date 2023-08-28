package edu.chunjae.controller.payment;

import edu.chunjae.dto.CartVO;
import edu.chunjae.dto.Custom;
import edu.chunjae.model.CartDAO;
import edu.chunjae.model.CustomDAO;

import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet("/PayCart.do")
public class PayCartCtrl extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        //세션 생성
        HttpSession session = request.getSession();
        String cid = (String) session.getAttribute("sid");

        CartDAO dao = new CartDAO();
        List<CartVO> cartList = dao.getByIdCartList(cid);

        CustomDAO cusDAO = new CustomDAO();
        Custom cus = cusDAO.getCustom(cid);


        request.setAttribute("cartList", cartList);
        request.setAttribute("cus", cus);

        RequestDispatcher view = request.getRequestDispatcher("/payment/paycart.jsp");
        view.forward(request, response);
    }
}