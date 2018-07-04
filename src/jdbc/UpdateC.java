package jdbc;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

@WebServlet(name = "UpdateC")
public class UpdateC extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request,response);

    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int upcid= Integer.parseInt(request.getParameter("upcid"));
        int upsid= Integer.parseInt(request.getParameter("upsid"));
        String upcname=request.getParameter("upcname");
        int upcprice= Integer.parseInt(request.getParameter("upcprice"));
        int upcnum= Integer.parseInt(request.getParameter("upcnum"));
        String sql="replace into commodity(cid,sid,cname,cprice,cnum)values(?,?,?,?,?);";
        Connection connection=DataBaseBean.getConnection();
        PreparedStatement preparedStatement=DataBaseBean.getPreparedStatement(connection,sql);
        try {
            preparedStatement.setInt(1,upcid);
            preparedStatement.setInt(2,upsid);
            preparedStatement.setString(3,upcname);
            preparedStatement.setInt(4,upcprice);
            preparedStatement.setInt(5,upcnum);
            preparedStatement.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        finally {
            DataBaseBean.ClosePreparedStatement(preparedStatement);
            DataBaseBean.CloseConnection(connection);
            RequestDispatcher requestDispatcher=request.getRequestDispatcher("publish.jsp");
            requestDispatcher.forward(request,response);
        }
    }

    }

