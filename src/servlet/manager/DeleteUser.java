package servlet.manager;

import domain.Manager;
import domain.User;
import service.userOption.UserOptionImp;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet("/DeleteUser")
public class DeleteUser extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("utf-8");
        int index = Integer.valueOf(req.getParameter("index"));
        Manager manager = (Manager)req.getSession().getAttribute("manager");
        List<User> users = manager.getUsers();
        User user = users.get(index);
        users.remove(index);
        new UserOptionImp().deleteUser(user.getId());
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        this.doGet(req, resp);
    }
}
