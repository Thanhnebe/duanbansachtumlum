package com.shop.filter;

import javax.servlet.*;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.*;
import java.io.IOException;

@WebFilter("/admin/*")
public class FilterWeb implements Filter {
    @Override
    public void doFilter(ServletRequest req, ServletResponse res, FilterChain chain)
            throws IOException, ServletException {
        HttpServletRequest r = (HttpServletRequest) req;
        HttpServletResponse s = (HttpServletResponse) res;
        HttpSession session = r.getSession(false);
        String role = session == null ? null : (String) session.getAttribute("role");

        if (role == null || !"ADMIN".equalsIgnoreCase(role)) {
            s.sendRedirect(r.getContextPath() + "/login.html?auth=required");
            return;
        }
        chain.doFilter(req, res);
    }
}
