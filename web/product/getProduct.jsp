<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>상품 상세보기</title>
    <c:set var="path" value="<%=request.getContextPath() %>" />
    <%@ include file="../common.jsp"%>
    <style>
    th.item1 { width:16%; }
    </style>
</head>
<body>
<div class="container-fluid">
    <%@ include file="../header.jsp"%>
    <div class="contents" style="min-height:100vh">
        <nav aria-label="breadcrumb container-fluid" style="padding-top:28px; border-bottom:2px solid #666;">
            <div class="container">
                <ol class="breadcrumb justify-content-end">
                    <li class="breadcrumb-item"><a href="${path }">Home</a></li>
                    <li class="breadcrumb-item"><a href="${path }/ProList.do">Product</a></li>
                    <li class="breadcrumb-item active" aria-current="page">Detail</li>
                </ol>
            </div>
        </nav>
        <h2 class="title">상품 상세보기</h2>
        <div class="container">
            <div class="box_wrap">
                <table class="table table-secondary" id="tb1">
                    <tbody>
                    <tr>
                        <td colspan="2">
                            <c:if test="${!empty pro.imgsrc1}">
                            <img src="${path }/storage/${pro.imgsrc1 }" alt="대표 이미지">
                            </c:if>
                            <hr>
                            <c:if test="${!empty pro.imgsrc3}">
                            <img src="${path }/storage/${pro.imgsrc3 }" alt="대표 이미지">
                            </c:if>
                        </td>
                    </tr>
                    <tr>
                        <th class="item1">도서 번호</th>
                        <td class="item2">${pro.prono }</td>
                    </tr>
                    <tr>
                        <th>도서명</th>
                        <td>${pro.pname }</td>
                    </tr>
                    <tr>
                        <th>도서 설명</th>
                        <td>
                            <pre>${pro.pcomment }</pre>
                        </td>
                    </tr>
                    <tr>
                        <th>도서 목차</th>
                        <td><pre>${pro.plist }</pre></td>
                    </tr>
                    <tr>
                        <th>가격</th>
                        <td>${pro.price }</td>
                    </tr>
                    <tr>
                        <th>남은 수량</th>
                        <td>
                            <c:if test="${amount <= 0}">
                                <span>절판</span>
                            </c:if>
                            <c:if test="${amount > 0}">
                                ${amount }
                            </c:if>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="2">
                            <c:if test="${!empty pro.imgsrc2}">
                            <img src="${path }/storage/${pro.imgsrc2 }" alt="대표 이미지">
                            </c:if>
                        </td>
                    </tr>
                    </tbody>
                </table>
                <div class="btn-wrap container">
                    <a href="${path }/ProList.do" class="btn btn-primary">제품 목록</a>
                    <c:if test="${sid.equals('admin') }">
                        <a href="${path }/AddReceive.do" class="btn btn-primary">상품 입고</a>
                    </c:if>
                    <c:if test="${!empty sid }">
                        <a href="${path }/AddPayment.do?pno=${pro.pno }" class="btn btn-primary">구매하기</a>
                        <a href="${path }/AddCart.do?pno=${pro.pno }" class="btn btn-primary">장바구니 담기</a>
                    </c:if>
                </div>
            </div>
        </div>
    </div>
    <%@ include file="../footer.jsp" %>
</div>
</body>
</html>
