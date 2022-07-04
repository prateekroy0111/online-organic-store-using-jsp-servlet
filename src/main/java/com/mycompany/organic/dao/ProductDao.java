package com.mycompany.organic.dao;

import com.mycompany.organic.entities.Product;
import java.util.List;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;

public class ProductDao {

    private SessionFactory factory;

    public ProductDao(SessionFactory factory) {
        this.factory = factory;
    }

    public boolean saveProduct(Product product) {
        boolean f = false;
        try {
            Session session = this.factory.openSession();
            Transaction tx = session.beginTransaction();
            session.save(product);
            tx.commit();
            session.close();
            f = true;
        } catch (Exception e) {
            e.printStackTrace();
            f = false;
        }
        return f;
    }

    //get all the products
    public List<Product> getAllProducts() {
        Session s = this.factory.openSession();
        Query q = s.createQuery("from Product");
        List<Product> list = q.list();
        return list;
    }

    //get product details by productId
    public boolean updateProductDetails(Product p) {
        boolean f = false;
        try {
            Session s = this.factory.openSession();
            Transaction tx = s.beginTransaction(); 
            Query query = s.createSQLQuery("UPDATE Product set pName = :pNm, pDescp = :pD, pPhoto = :pPho, pPrice = :pPri, pDiscount = :pDis, pQuantity = :pQty, category_categoryID =:cId where pId = :pid");
            query.setParameter("pid", p.getpId());
            query.setParameter("pNm", p.getpName());
            query.setParameter("pD", p.getpDescp());
            query.setParameter("pPho", p.getpPhoto());
            query.setParameter("pPri", p.getpPrice());
            query.setParameter("pDis", p.getpDiscount());
            query.setParameter("pQty", p.getpQuantity());
            query.setParameter("cId", p.getCategory().getCategoryId());
            
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

    //get all products of given category
    public List<Product> getAllProductsById(int cid) {
        Session s = this.factory.openSession();
        Query q = s.createQuery("from Product where category.categoryId =: id");
        q.setParameter("id", cid);
        List<Product> list = q.list();
        return list;
    }

    //get products of given pid
    public Product getProductDetailsById(int pid) {
        Session s = this.factory.openSession();
        Query q = s.createQuery("from Product where pId =: id");
        q.setParameter("id", pid);
        q.setMaxResults(1);
        Product productObj = (Product) q.uniqueResult();
//        List<Product> list = q.list();
        return productObj;
    }

    //delete product of given pid
    public int deleteProductById(int pid) {
        Session s = this.factory.openSession();
        Transaction tx = s.beginTransaction();
        Query q = s.createQuery("delete Product where pId =: id");
        q.setParameter("id", pid);
        int res = q.executeUpdate();
        tx.commit();
        return res;
    }
}
