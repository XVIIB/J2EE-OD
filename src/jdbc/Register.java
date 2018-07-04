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
import java.sql.Statement;

@WebServlet(name = "Register")
public class Register extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request,response);

    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession hs=request.getSession(true);
        String uname=request.getParameter("registeruname");
        String password=request.getParameter("registerpwd");
        int phone= Integer.parseInt(request.getParameter("registerphone"));
        String sql="INSERT INTO user(uname,upwd,utel,udate) VALUES(?,?,?,now())";
        Connection connection=null;
        PreparedStatement preparedStatement=null;
        connection=DataBaseBean.getConnection();
        preparedStatement=DataBaseBean.getPreparedStatement(connection,sql);
        try {
            preparedStatement.setString(1,uname);
            preparedStatement.setString(2,password);
            preparedStatement.setInt(3,phone);
            int a=preparedStatement.executeUpdate();
            if (a==1){
                RequestDispatcher requestDispatcher=request.getRequestDispatcher("index.jsp");
                requestDispatcher.forward(request,response);
            }
            else {
            }
            System.out.println(a);
        } catch (SQLException e) {
            e.printStackTrace();
            RequestDispatcher requestDispatcher=request.getRequestDispatcher("register.jsp");
            requestDispatcher.forward(request,response);
            hs.setAttribute("registerinfo","重复");
        }
        finally {
            DataBaseBean.ClosePreparedStatement(preparedStatement);
            DataBaseBean.CloseConnection(connection);
        }
    }
}
