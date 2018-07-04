package jdbc;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.swing.text.html.HTMLDocument;
import java.awt.*;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.*;
import java.util.ArrayList;
import java.util.Date;
import java.util.Vector;

@WebServlet(name = "OrderCommit")
public class OrderCommit extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request,response);

    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html");
        HttpSession hs=request.getSession();
        java.util.Date date=new Date();
        int id= (int) hs.getAttribute("user");
        int aid;
        int oid;
        int price = 0;
        int dprice=0;
        Connection connection=null;
        PreparedStatement preparedStatement1=null;
        PreparedStatement preparedStatement2=null;
        PreparedStatement preparedStatement3=null;
        PreparedStatement preparedStatement4=null;
        PreparedStatement preparedStatement5=null;
        PreparedStatement preparedStatement6=null;
        ResultSet resultSet=null;
        String sql1=null;
        String sql2=null;
        String sql3=null;
        String sql4=null;
        String sql5=null;
        String sql6=null;
        ArrayList list=new ArrayList();
        ArrayList list1= (ArrayList) hs.getAttribute("car");
        System.out.println("list1:0"+list1.get(0));
        //System.out.println("list:0"+list.get(0));
        for (int i = 0; i <list1.size() ; i++) {
            list.add(list1.get(i));
        }
        connection=DataBaseBean.getConnection();
        try {
            connection.setAutoCommit(false);
            sql1="select aid from addr where uid=?;";
            sql2="insert into orders(oid,uid,aid,odate)values(?,?,?,now())";
            sql3="insert into orderdetail(cid,oid,dprice)values(?,?,?)";
            sql4="select cprice from commodity where cid=?";
            sql5="update orders set oprice=(select sum(dprice) from orderdetail where oid=?) where oid=?";
            sql6="update commodity set cnum=cnum-1 where cid=?";

            preparedStatement1=DataBaseBean.getPreparedStatement(connection,sql1);
            preparedStatement1.setInt(1,id);
            resultSet=preparedStatement1.executeQuery();
            resultSet.next();
            aid=resultSet.getInt("aid");
            oid=aid+ (int) date.getTime();
            //插入订单
            preparedStatement2=DataBaseBean.getPreparedStatement(connection,sql2);
            preparedStatement2.setInt(1,oid);
            preparedStatement2.setInt(2,id);
            preparedStatement2.setInt(3,aid);
            preparedStatement2.executeUpdate();
            preparedStatement3=DataBaseBean.getPreparedStatement(connection,sql3);
            preparedStatement4=DataBaseBean.getPreparedStatement(connection,sql4);
            for (int i=0;i<list.size();i++){
                //商品数量减1
                preparedStatement6=DataBaseBean.getPreparedStatement(connection,sql6);
                preparedStatement6.setInt(1, (Integer) list.get(i));
                preparedStatement6.executeUpdate();
                //查询价格
                preparedStatement4.setInt(1, (Integer) list.get(i));
                resultSet=preparedStatement4.executeQuery();
                resultSet.next();
                dprice=resultSet.getInt("cprice");
                //插入订单细节
                preparedStatement3.setInt(1, (Integer) list.get(i));
                preparedStatement3.setInt(2,oid);
                preparedStatement3.setInt(3,dprice);
                preparedStatement3.executeUpdate();
            }
            //插入订单价格
            preparedStatement5=DataBaseBean.getPreparedStatement(connection,sql5);
            preparedStatement5.setInt(1,oid);
            preparedStatement5.setInt(2,oid);
            preparedStatement5.executeUpdate();

            connection.commit();
            hs.setAttribute("finished","提交订单成功");

        } catch (SQLException e) {
            try {
                connection.rollback();
                RequestDispatcher requestDispatcher1=request.getRequestDispatcher("login.jsp");
                requestDispatcher1.forward(request,response);
            } catch (SQLException e1) {
                RequestDispatcher requestDispatcher1=request.getRequestDispatcher("login.jsp");
                requestDispatcher1.forward(request,response);
                e1.printStackTrace();
                hs.setAttribute("finished","提交订单失败");
            }
            hs.setAttribute("finished","提交订单失败");
            e.printStackTrace();
        }
        finally {
            DataBaseBean.CloseResustSet(resultSet);
            DataBaseBean.ClosePreparedStatement(preparedStatement1);
            DataBaseBean.ClosePreparedStatement(preparedStatement2);
            DataBaseBean.ClosePreparedStatement(preparedStatement3);
            DataBaseBean.ClosePreparedStatement(preparedStatement4);
            DataBaseBean.ClosePreparedStatement(preparedStatement5);
            DataBaseBean.ClosePreparedStatement(preparedStatement6);
            DataBaseBean.CloseConnection(connection);
            RequestDispatcher requestDispatcher=request.getRequestDispatcher("show.jsp");
            requestDispatcher.forward(request,response);
        }

    }
}
