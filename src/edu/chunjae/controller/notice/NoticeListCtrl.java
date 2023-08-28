package edu.chunjae.controller.notice;

import edu.chunjae.dto.Notice;
import edu.chunjae.model.NoticeDAO;

import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet("/NoticeList.do")
public class NoticeListCtrl extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setAttribute("msg", "공지사항 목록을 출력합니다.");

        NoticeDAO dao = new NoticeDAO();
        List<Notice> notiList = dao.getNoticeList();
        request.setAttribute("notiList", notiList);

        RequestDispatcher view = request.getRequestDispatcher("/notice/noticeList.jsp");
        view.forward(request, response);
    }
}
