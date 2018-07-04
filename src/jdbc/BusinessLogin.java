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
import java.sql.ResultSet;
import java.sql.SQLException;

@WebServlet(name = "BusinessLogin")
public class BusinessLogin extends HttpServlet {
    protected void doPost(javax.servlet.http.HttpServletRequest request, javax.servlet.http.HttpServletResponse response) throws javax.servlet.ServletException, IOException {
        doGet(request,response);

    }

    protected void doGet(javax.servlet.http.HttpServletRequest request, javax.servlet.http.HttpServletResponse response) throws javax.servlet.ServletException, IOException {
        HttpSession hs=request.getSession(true);
        Connection connection=null;
        PreparedStatement ps=null;
        ResultSet rs=null;
        connection=DataBaseBean.getConnection();
        String sql="SELECT bid,bname,bpwd FROM business WHERE bname=?";
        ps=DataBaseBean.getPreparedStatement(connection,sql);
        String bname=request.getParameter("bname");
        String bpwd=request.getParameter("bpwd");
        try {
            ps.setString(1,bname);
            rs=DataBaseBean.getResultset(ps);
            if (rs.next()){
                if (bpwd.equals(rs.getString("bpwd"))){
                    System.out.println("成功");
                    int bid=rs.getInt("bid");
                    System.out.println(bid);
                    hs.setAttribute("buser",bid);
                    System.out.println(hs.getAttribute("buser"));
                    RequestDispatcher rd=request.getRequestDispatcher("publish.jsp");
                    rd.forward(request,response);
                }
                else {
                    System.out.println("密码错误");
                    RequestDispatcher rd=request.getRequestDispatcher("businesslogin.jsp");
                    hs.setAttribute("bue","用户名");
                    hs.setAttribute("bpe","密码错误");
                    rd.forward(request,response);
                }
            }
            else {
                System.out.println("用户名错误");
                hs.setAttribute("bue","用户名错误");
                hs.setAttribute("bpe","密码");
                RequestDispatcher rd=request.getRequestDispatcher("businesslogin.jsp");
                rd.forward(request,response);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        finally {
            DataBaseBean.CloseResustSet(rs);
            DataBaseBean.ClosePreparedStatement(ps);
            DataBaseBean.CloseConnection(connection);
        }
    }
}
