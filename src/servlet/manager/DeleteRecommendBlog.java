package servlet.manager;

import domain.Blog;
import domain.Manager;
import service.blogOption.BlogOptionImp;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet("/DeleteRecommendBlog")
public class DeleteRecommendBlog extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("utf-8");
        int index = Integer.valueOf(req.getParameter("index"));
        Manager manager = (Manager)req.getSession().getAttribute("manager");
        List<Blog> blogs = manager.getBlogs();
        new BlogOptionImp().updateRecommendBlog(blogs.get(index).getId(), false);
        blogs.remove(index);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        this.doGet(req, resp);
    }
}
