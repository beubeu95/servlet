<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=no">
    <title>메인 페이지</title>
    <c:set var="path" value="<%=request.getContextPath() %>" />
    <%@ include file="/common.jsp"%>
  </head>
  <body>
  <div class="container-fluid">
      <%@ include file="/header.jsp"%>
      <div class="contents">
          <h2>사용자 : ${user }</h2>
          <h2>메인 절대 주소 : ${realPath }</h2>
          <h2>메인 상대 주소 : ${path }</h2>
          <hr>
          <table class="table">
              <thead>
              <tr>
                  <th>이미지1</th>
                  <th>이미지2</th>
              </tr>
              </thead>
              <tbody>
                  <tr>
                      <td><img src="./img/img01.webp" alt="이미지1" width="400"></td>
                      <td><img src="./images/img02.webp" alt="이미지2" width="400"></td>
                  </tr>
              </tbody>
          </table>
          <div class="btn-group">
              <a href="" class="btn btn-primary">서브1</a>
              <a href="" class="btn btn-primary">서브2</a>
          </div>
      </div>
      <%@ include file="/footer.jsp" %>
  </div>
  </body>
</html>
