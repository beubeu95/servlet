package edu.chunjae.model;

import edu.chunjae.dto.Cart;
import edu.chunjae.dto.Delivery;
import edu.chunjae.dto.Payment;
import edu.chunjae.dto.Serve;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class MultiPattern {
    static DBConnect con = new PostgreCon();

    Connection conn = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;

    public MultiPattern(){

    }

    public int pay(Payment payment, Serve serve, Delivery delivery, Cart cart) {
        int sno = 0;
        conn = con.connect();
        String sql = "";


        try {
            conn.setAutoCommit(false);
            int cnt = 0;

            //결제 처리
            sql = "insert into payment values (default, ?, ?, ?, ?, ?, ?, ?, '')";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, payment.getCid());
            pstmt.setInt(2, payment.getPno());
            pstmt.setInt(3, payment.getAmount());
            pstmt.setString(4, payment.getPmethod());
            pstmt.setString(5, payment.getPcom());
            pstmt.setString(6, payment.getCnum());
            pstmt.setInt(7, payment.getPayprice());
            cnt += pstmt.executeUpdate();

            //출고 처리
            sql = "insert into serve values(default, ?, ?, ?, default)";
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, payment.getPno());
            pstmt.setInt(2, payment.getAmount());
            pstmt.setInt(3, payment.getPayprice());
            cnt += pstmt.executeUpdate();

            //출고 처리후 번호 반환
            sql = "select sno from payment order by sno desc limit 1";
            pstmt = conn.prepareStatement(sql);
            rs = pstmt.executeQuery();

            if (rs.next()) {
                sno = rs.getInt("sno");
            }

            //배송 처리
            sql = "insert into delivery values (default, ?, ?, ?, ?, '','',default,default,'','')";
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, delivery.getSno());
            pstmt.setString(2, delivery.getCid());
            pstmt.setString(3, delivery.getDaddr());
            pstmt.setString(4, delivery.getCustel());
            cnt += pstmt.executeUpdate();

            //카트 삭제 처리
            sql = "delete from cart where cartno=?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, cart.getCartno());
            cnt += pstmt.executeUpdate();

            conn.commit();
            conn.setAutoCommit(true);
        } catch (SQLException e) {
            try {
                conn.rollback();
            } catch (SQLException ex) {
                throw new RuntimeException(ex);
            }
            throw new RuntimeException(e);
        }
        return sno;
    }

}
