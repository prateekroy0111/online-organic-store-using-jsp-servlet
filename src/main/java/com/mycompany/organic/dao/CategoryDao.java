package com.mycompany.organic.dao;

import com.mycompany.organic.entities.Category;
import java.util.List;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;

public class CategoryDao {

    private SessionFactory factory;

    public CategoryDao(SessionFactory factory) {
        this.factory = factory;
    }

    //saves category to db
    public int saveCategory(Category cat) {
        int CatId = 0;
        try {
            Session session = this.factory.openSession();
            Transaction tx = session.beginTransaction();
            CatId = (int) session.save(cat);
            tx.commit();
            session.close();

        } catch (Exception e) {
            e.printStackTrace();
        }
        return CatId;

    }

    public List<Category> getCategories() {
        Session s = this.factory.openSession();
        Query q = s.createQuery("from Category");
        List<Category> list = q.list();
        return list;
    }

    public Category getCategoryById(int cid) {
        Category cat = null;
        try {
            Session s1 = this.factory.openSession();
            cat = s1.get(Category.class, cid);

        } catch (Exception e) {
            e.printStackTrace();
        }
        return cat;
    }

    public boolean updateCategoryDetails(Category p) {
        boolean f = false;
        try {
            Session s = this.factory.openSession();
            Transaction tx = s.beginTransaction();
            Query query = s.createSQLQuery("UPDATE Category set categoryName = :cNm, categoryDescp = :cD where categoryId = :cid");
            query.setParameter("cid", p.getCategoryId());
            query.setParameter("cNm", p.getCategoryName());
            query.setParameter("cD", p.getCategoryDescp());

            int result = query.executeUpdate();
            tx.commit();
//            s.close();
            f = true;
        } catch (Exception e) {
            e.printStackTrace();
            f = false;
        }
        return f;
    }

    public int deleteCategoryById(int cid) {
        Session s = this.factory.openSession();
        Transaction tx = s.beginTransaction();
        Query q = s.createQuery("delete Category where categoryId =: cid");
        q.setParameter("cid", cid);
        int res = q.executeUpdate();
        tx.commit();
        return res;
    }
}
