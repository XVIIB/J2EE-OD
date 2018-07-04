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

@WebServlet(name = "PublishC")
public class PublishC extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request,response);

    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int sid= Integer.parseInt(request.getParameter("psid"));
        String cname=request.getParameter("pcname");
        int cprice= Integer.parseInt(request.getParameter("pcprice"));
        int cnum= Integer.parseInt(request.getParameter("pcnum"));
        String sql="insert into commodity(sid,cname,cprice,cnum)values(?,?,?,?);";
        Connection connection=DataBaseBean.getConnection();
        PreparedStatement preparedStatement=DataBaseBean.getPreparedStatement(connection,sql);
        try {
            preparedStatement.setInt(1,sid);
            preparedStatement.setString(2,cname);
            preparedStatement.setInt(3,cprice);
            preparedStatement.setInt(4,cnum);
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
