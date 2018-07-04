package jdbc;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.ArrayList;

@WebServlet(name = "AddCar")
public class AddCar extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request,response);

    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession hs=request.getSession();
        //int cid= (int) hs.getAttribute("cid");
        int cid= Integer.parseInt(request.getParameter("input1"));
        ArrayList carList= (ArrayList) hs.getAttribute("car");

        if (carList==null){
            carList=new ArrayList();
            carList.add(cid);
            hs.setAttribute("car",carList);
            System.out.println("kong");
        }
        else{
            carList.add(cid);
            hs.setAttribute("car",carList);
            System.out.println("man");
        }
        for (int i = 0; i <carList.size() ; i++) {
            System.out.println(carList.get(i));
        }
        hs.setAttribute("finished","添加购物车成功");
        RequestDispatcher requestDispatcher=request.getRequestDispatcher("show.jsp");
        requestDispatcher.forward(request,response);
    }
}
