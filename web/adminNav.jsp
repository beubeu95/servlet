<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:set var="path2" value="<%=request.getContextPath() %>" />
<nav class="navbar">
    <ul class="navbar-nav">
        <li class="nav-item">
            <a href="" class="nav-link">공지사항 관리</a>
        </li>
        <li class="nav-item"><a href="">상품 등록</a>
            <ul class="navbar-nav">
                <li class="nav-item"><a href="${path2 }/AddProduct.do" class="nav-link">상품등록</a></li>
                <li class="nav-item"><a href="${path2 }/AddReceive.do" class="nav-link">입고</a></li>
                <li class="nav-item"><a href="" class="nav-link"></a></li>
                <li class="nav-item"><a href="" class="nav-link"></a></li>
            </ul>
        </li>
        <li class="nav-item"><a href="" class="nav-link">댓글 관리</a></li>
    </ul>
</nav>