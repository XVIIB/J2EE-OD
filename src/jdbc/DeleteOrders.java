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

@WebServlet(name = "DeleteOrders")
public class DeleteOrders extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request,response);

    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int oid= Integer.parseInt(request.getParameter("delete1"));
        HttpSession hs=request.getSession();
        int uid;
        uid=(int) hs.getAttribute("user");
        String sql="delete from orders where oid = ? and uid=?";
        Connection connection=DataBaseBean.getConnection();
        PreparedStatement preparedStatement=DataBaseBean.getPreparedStatement(connection,sql);
        try {
            preparedStatement.setInt(1,oid);
            preparedStatement.setInt(2,uid);
            preparedStatement.executeUpdate();
            hs.setAttribute("deleted","删除成功");
            RequestDispatcher requestDispatcher=request.getRequestDispatcher("selectOrders.jsp");
            requestDispatcher.forward(request,response);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        finally {
            DataBaseBean.ClosePreparedStatement(preparedStatement);
            DataBaseBean.CloseConnection(connection);
        }
    }
}
