package jdbc;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

@WebServlet(name = "ChangeInfo")
public class ChangeInfo extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request,response);

    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession hs=request.getSession();
        int uid= (int) hs.getAttribute("user");
        String sql1="update user set utel=?,upwd=? where uid=?";
        String sql2="replace into addr set uid=?, acity=?,adetail=?,aname=?";
        String changepwd=request.getParameter("changepwd");
        int changephone= Integer.parseInt(request.getParameter("changephone"));
        String changecity=request.getParameter("changecity");
        String changeaddr=request.getParameter("changeaddr");
        String changename=request.getParameter("changename");
        Connection connection=DataBaseBean.getConnection();
        PreparedStatement preparedStatement1=DataBaseBean.getPreparedStatement(connection,sql1);
        PreparedStatement preparedStatement2=DataBaseBean.getPreparedStatement(connection,sql2);
        try {
            //更改用户表
            preparedStatement1.setInt(1,changephone);
            preparedStatement1.setString(2,changepwd);
            preparedStatement1.setInt(3,uid);
            preparedStatement1.executeUpdate();
            //更改地址表
            preparedStatement2.setInt(1,uid);
            preparedStatement2.setString(2,changecity);
            preparedStatement2.setString(3,changeaddr);
            preparedStatement2.setString(4,changename);
            preparedStatement2.executeUpdate();

        } catch (SQLException e) {
            RequestDispatcher requestDispatcher1=request.getRequestDispatcher("login.jsp");
            requestDispatcher1.forward(request,response);
            e.printStackTrace();
        }
        finally {
            DataBaseBean.ClosePreparedStatement(preparedStatement1);
            DataBaseBean.ClosePreparedStatement(preparedStatement2);
            DataBaseBean.CloseConnection(connection);
            RequestDispatcher requestDispatcher=request.getRequestDispatcher("changInfo.jsp");
            requestDispatcher.forward(request,response);
        }

    }
}
