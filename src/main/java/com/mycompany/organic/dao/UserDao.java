package com.mycompany.organic.dao;

import com.mycompany.organic.entities.User;
import java.util.List;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;

public class UserDao {

    private SessionFactory factory;

    public UserDao(SessionFactory factory) {
        this.factory = factory;
    }

    //get user by email and password
    public User getUserByEmailAndPassword(String Email, String Pass) {
        User user = null;
        try {
            String query = "from User where userMail =: e and userPass=: p";
            Session session = this.factory.openSession();
            Query q = session.createQuery(query);
            q.setParameter("e", Email);
            q.setParameter("p", Pass);

            user = (User) q.uniqueResult();

            session.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return user;
    }
    
    public List<User> getAllUsers() {
        Session s = this.factory.openSession();
        Query q = s.createQuery("from User where userType =: user_type");
        q.setParameter("user_type", "normal");
        List<User> list = q.list();
        return list;
    }
    
    //get products of given pid
    public User getUserDetailsById(int uid) {
        Session s = this.factory.openSession();
        Query q = s.createQuery("from User where userId =: id");
        q.setParameter("id", uid);
        q.setMaxResults(1);
        User userObj = (User) q.uniqueResult();
        return userObj;
    }
}
