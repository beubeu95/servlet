<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>장바구니 목록</title>
    <c:set var="path" value="<%=request.getContextPath() %>" />
    <%@ include file="../common.jsp"%>
    <style>
        #tb1 { width:960px; margin:40px auto; }
        #tb1 th { background-color: #111; color:#fff; }
        .item1 { width:60%; }
        .item2 { width:10%; }
        .item3 { width:10%; }
        .item4 { width:10%; }
        #page-nation1 { width: 960px; margin:20px auto; }
    </style>
</head>
<body>
<div class="container-fluid">
    <%@ include file="../header.jsp"%>
    <div class="contents" style="min-height:100vh">
        <div id="carouselExample" class="carousel slide">
            <div class="carousel-inner" style="max-height:360px;overflow:hidden;">
                <div class="carousel-item active">
                    <img src="${path }/images/sub_vs01.jpg" class="d-block w-100" alt="천재교과서">
                </div>
                <div class="carousel-item">
                    <img src="${path }/images/sub_vs02.jpg" class="d-block w-100" alt="천재문제집">
                </div>
                <div class="carousel-item">
                    <img src="${path }/images/sub_vs03.jpg" class="d-block w-100" alt="천재참고서">
                </div>
            </div>
            <button class="carousel-control-prev" type="button" data-bs-target="#carouselExample" data-bs-slide="prev">
                <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                <span class="visually-hidden">Previous</span>
            </button>
            <button class="carousel-control-next" type="button" data-bs-target="#carouselExample" data-bs-slide="next">
                <span class="carousel-control-next-icon" aria-hidden="true"></span>
                <span class="visually-hidden">Next</span>
            </button>
        </div>
        <nav aria-label="breadcrumb container-fluid" style="padding-top:28px; border-bottom:2px solid #666;">
            <div class="container">
                <ol class="breadcrumb justify-content-end">
                    <li class="breadcrumb-item"><a href="${path }">Home</a></li>
                    <li class="breadcrumb-item"><a href="#">Cart</a></li>
                    <li class="breadcrumb-item active" aria-current="page">List</li>
                </ol>
            </div>
        </nav>
        <h2 class="title">장바구니 결제</h2>
        <p class="msg">${msg }</p>
        <div class="container">
            <div class="box_wrap">
                <form action="${path }/PayCartPro.do" method="post">
                    <table class="table table-secondary" id="tb1">
                        <thead>
                        <tr>
                            <th class="item1">상품명</th>
                            <th class="item2">수량</th>
                            <th class="item3">가격</th>
                            <th class="item4">총계</th>
                        </tr>
                        </thead>
                        <tbody>
                        <c:forEach var="cart" items="${cartList }" >
                            <tr>
                                <td class="item1">
                                    <span title="${cart.pno}">${cart.pname }</span>
                                </td>
                                <td class="item2">
                                        ${cart.amount }
                                    <a href="${path }/AddPayment.do?pno=${cart.pno }&from=cart"></a>
                                </td>
                                <td class="item3">
                                        ${cart.price }
                                </td>
                                <td class="item4 subtotal">
                                        ${cart.price*cart.amount }
                                </td>
                            </tr>
                        </c:forEach>
                        <c:if test="${empty cartList}">
                            <tr>
                                <td colspan="3">장바구니 목록이 존재하지 않습니다.</td>
                            </tr>
                        </c:if>
                        </tbody>
                    </table>
                    <c:if test="${!empty cartList}">
                        <div class="container">
                            <div class="checkout__order__subtotal" id="subprice"></div>
                            <div class="checkout__order__total" id="totalprice"></div>
                        </div>
                    </c:if>
                    <h3>배송 정보</h3>
                    <table class="table">
                        <tbody>
                        <tr>
                            <th>배송지 주소</th>
                            <td><input type="text" name="address1" id="address1" placeholder="기본 주소 입력" class="form-control" required /><br>
                                <input type="text" name="address2" id="address2" placeholder="상세 주소 입력" class="form-control" required /><br>
                                <input type="text" name="postcode" id="postcode" style="width:160px;float:left;margin-right:20px;" placeholder="우편번호" class="form-control" required>
                                <button type="button" id="post_btn" onclick="findAddr()" class="btn btn-primary" style="margin-bottom:36px;">우편번호 검색</button>
                            </td>
                        </tr>
                        <tr>
                            <th>받는 사람 연락처</th>
                            <td>
                                <input type="hidden" name="cid" id="cid" value="${cus.id }">
                                <input type="hidden" name="name" id="name" value="${cus.name }">
                                <input type="hidden" name="email" id="email" value="${cus.email }">
                                <input type="hidden" name="tel" id="tel" value="${cus.tel }">
                                <input type="hidden" name="addr" id="addr" value="${cus.addr }">
                                <input type="tel" name="custel" id="custel" class="form-control" required>
                            </td>
                        </tr>
                        </tbody>
                    </table>
                    <hr>
                    <h3>결제 정보</h3>
                    <table class="table">
                        <tbody>
                        <tr>
                            <th>결제 수단</th>
                            <td>
                                <select name="pmethod" id="pmethod" class="form-control">
                                    <option value="신용카드">신용카드</option>
                                    <option value="체크카드">체크카드</option>
                                    <option value="계좌이체">계좌이체</option>
                                </select>
                            </td>
                        </tr>
                        <tr>
                            <th>결제사</th>
                            <td>
                                <select name="pcom" id="pcom" class="form-control">
                                    <option value="선택안함">선택안함</option>
                                </select>
                                <input type="hidden" name="pcom2" id="pcom2" value="">
                            </td>
                        </tr>
                        <tr>
                            <th>결제 번호</th>
                            <td>
                                <input type="text" name="cnum" id="cnum" class="form-control" required>
                                <input type="hidden" name="payAmount" id="payAmount">
                                <input type="hidden" name="payCk" id="payCk" value="no">
                            </td>
                        </tr>
                        <tr>
                            <td colspan="2">
                                <input type="submit" id="pay" value="결제" class="btn btn-primary">
                            </td>
                        </tr>
                        </tbody>
                    </table>
                </form>
                <script>
                    $(document).ready(function(){
                        var cardArr1 = ["현대카드","농협카드","BC카드","KB카드"];
                        var cardArr2 = ["하나카드","농협카드","BC카드"];
                        var bankArr = ["카카오뱅크","농협은행","신한은행","기업은행","국민은행"];
                        $("#pmethod").change(function(){
                            var th = $(this).val();
                            if(th==="신용카드"){
                                for(var i=0;i<cardArr1.length;i++) {
                                    $("#pcom").append("<option value='" + cardArr1[i] + "'>" + cardArr1[i] + "</option>");
                                }
                            } else if(th==="체크카드"){
                                for(var i=0;i<cardArr2.length;i++) {
                                    $("#pcom").append("<option value='"+cardArr2[i]+"'>"+cardArr2[i]+"</option>");
                                }
                            } else {
                                for(var i=0;i<bankArr.length;i++) {
                                    $("#pcom").append("<option value='"+bankArr[i]+"'>"+bankArr[i]+"</option>");
                                }
                            }
                        }).change();
                        $("#pcom").change(function(){
                            $("#pcom2").val($(this).val());
                        });
                    });
                </script>
                <script>
                    //주소 연동 API
                    function findAddr() {
                        new daum.Postcode({
                            oncomplete: function(data) {
                                console.log(data);
                                var roadAddr = data.roadAddress;
                                var jibunAddr = data.jibunAddress;
                                document.getElementById("postcode").value = data.zonecode;
                                if(roadAddr !== '') {
                                    document.getElementById("address1").value = roadAddr;
                                } else if(jibunAddr !== ''){
                                    document.getElementById("address1").value = jibunAddr;
                                }
                                document.getElementById("address2").focus();
                            }
                        }).open();
                    }
                </script>
                <script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
                <script>
                    //결제모듈 API 연동
                    $(document).ready(function(){
                        var totalPay=0;
                        var proName;

                        $(".subtotal").each(function(){
                            totalPay = totalPay + parseInt($(this).text());
                            console.log(totalPay);
                        });

                        //합계를 출력
                        $("#subprice").html("<span>SubTotal : "+totalPay+"</span>");
                        $("#totalprice").html("<span> Total : "+totalPay+"</span>");


                        $("#pay").click(function(){
                            var email = $("#name").val();
                            var cname = $("#email").val();
                            var tel = $("#tel").val();
                            var addr = $("#addr").val();
                            var postcode = $("#postcode").val();
                            proName = $("#proName").val();

                            alert("결제할 금액 : "+totalPay);
                            //상품명_현재시간
                            var d = new Date();
                            var date = d.getFullYear()+''+(d.getMonth()+1)+''+d.getDate()+''+d.getHours()+''+d.getMinutes()+''+d.getSeconds();
                            IMP.init('imp31083748'); // 결제 API를 사용하기 위한 코드 입력!
                            IMP.request_pay({		//결제 요청
                                merchant_uid : '상품명_' + date, //상점 거래 ID
                                name : proName,				// 결제 명
                                amount : totalPay,					// 결제금액
                                buyer_email : email, // 구매자 email
                                buyer_name : cname,				// 구매자 이름
                                buyer_tel : tel,		// 구매자 전화번호
                                buyer_addr : addr,		// 구매자 주소
                                buyer_postcode : postcode			// 구매자 우편번호
                            }, function(rsp){
                                if(rsp.success){
                                    console.log(rsp);
                                    var msg = '결제가 완료 되었습니다.';
                                    var r1 = '고유 아이디 : ' +rsp.imp_uid;
                                    var r2 = '상점 거래 아이디 : ' +rsp.merchant_uid;
                                    var r3 = '결제 금액 : ' +rsp.paid_amount;
                                    var r4 = '카드 승인 번호 : '+rsp.apply_num;

                                    //$("#payCk").val("yes");
                                    //$("#payAmount").val(rsp.paid_amount);
                                    //$("#pmethod").val(rsp.pay_method);
                                    //$("#pcom").val(rsp.pg_provider);
                                    //$("#cnum").val(rsp.apply_num);
                                    //alert(msg);
                                    //$("#paymentResult").html(r1+"<br>"+r2+"<br>"+r3+"<br>"+r4);
                                } else{
                                    //$("#paymentResult").html('결제실패<br>'+'에러내용 : ' +rsp.error_msg);
                                }
                                //테스트용이므로 실패시에도 그냥 통과시킴
                                $("#payCk").val("yes");
                                $("#payAmount").val(totalPay);
                                $("#pmethod").val("신용카드");
                                $("#pcom").val("삼성카드");
                                $("#cnum").val("123-1234-1234-1278");
                                $("#paymentResult").text("결제 완료 : "+totalPay);
                            });
                        });
                    });
                </script>
                <script>
                    function payCheck(f){
                        var payCk = f.payCk.value;
                        if(payCk!="yes"){
                            alert("아직 결제 전 입니다.");
                            return;
                        }
                    }
                </script>
            </div>
            <div class="container">
                <p id="paymentResult" style="color:red;font-size:28px;font-weight:800;">결제 전</p>
            </div>
        </div>
    </div>
            </div>
        </div>
    </div>
    <%@ include file="../footer.jsp" %>
</div>
</body>
</html>