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

@WebServlet(name = "DelateC")
public class DelateC extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request,response);

    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int cid= Integer.parseInt(request.getParameter("pdelate"));
        String sql="delete from commodity where cid=?;";
        Connection connection=DataBaseBean.getConnection();
        PreparedStatement preparedStatement=DataBaseBean.getPreparedStatement(connection,sql);
        try {
            preparedStatement.setInt(1,cid);
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
