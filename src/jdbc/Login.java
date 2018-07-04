package jdbc;

import javax.servlet.RequestDispatcher;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class Login extends javax.servlet.http.HttpServlet {
    protected void doPost(javax.servlet.http.HttpServletRequest request, javax.servlet.http.HttpServletResponse response) throws javax.servlet.ServletException, IOException {
        doGet(request,response);

    }

    protected void doGet(javax.servlet.http.HttpServletRequest request, javax.servlet.http.HttpServletResponse response) throws javax.servlet.ServletException, IOException {
        HttpSession hs=request.getSession(true);
        Connection connection=null;
        PreparedStatement ps=null;
        ResultSet rs=null;
        connection=DataBaseBean.getConnection();
        String sql="SELECT uid,uname,upwd FROM user WHERE uname=?";
        ps=DataBaseBean.getPreparedStatement(connection,sql);
        String uname=request.getParameter("uname");
        String upwd=request.getParameter("upwd");
        try {
            ps.setString(1,uname);
            rs=DataBaseBean.getResultset(ps);
            if (rs.next()){
                if (upwd.equals(rs.getString("upwd"))){
                    System.out.println("成功");
                   int id=rs.getInt("uid");
                    System.out.println(id);
                   hs.setAttribute("user",id);
                    System.out.println(hs.getAttribute("user"));
                   RequestDispatcher rd=request.getRequestDispatcher("show.jsp");
                   rd.forward(request,response);
                }
                else {
                    System.out.println("密码错误");
                    RequestDispatcher rd=request.getRequestDispatcher("login.jsp");
                    hs.setAttribute("ue","用户名");
                    hs.setAttribute("pe","密码错误");
                    rd.forward(request,response);
                }
            }
            else {
                System.out.println("用户名错误");
                hs.setAttribute("ue","用户名错误");
                hs.setAttribute("pe","密码");
                RequestDispatcher rd=request.getRequestDispatcher("login.jsp");
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
