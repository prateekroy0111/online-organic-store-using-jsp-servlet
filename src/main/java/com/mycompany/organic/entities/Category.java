
package com.mycompany.organic.entities;

import java.util.ArrayList;
import java.util.List;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.OneToMany;

@Entity
public class Category {
    @Id
    @GeneratedValue(strategy=GenerationType.IDENTITY)
    private int categoryId;
    private String categoryName;
    private String categoryDescp;
    @OneToMany(mappedBy="category")
    private List<Product> products = new ArrayList<>(); 
    public Category(int categoryId, String categoryName, String categoryDescp) {
        this.categoryId = categoryId;
        this.categoryName = categoryName;
        this.categoryDescp = categoryDescp;
    }

    public Category(String categoryName, String categoryDescp, List<Product> products) {
        this.categoryName = categoryName;
        this.categoryDescp = categoryDescp;
        this.products=products;
    }

    public Category() {
        
    }
    

    public int getCategoryId() {
        return categoryId;
    }

    public void setCategoryId(int categoryId) {
        this.categoryId = categoryId;
    }

    public String getCategoryName() {
        return categoryName;
    }

    public void setCategoryName(String categoryName) {
        this.categoryName = categoryName;
    }

    public String getCategoryDescp() {
        return categoryDescp;
    }

    public void setCategoryDescp(String categoryDescp) {
        this.categoryDescp = categoryDescp;
    }

    public List<Product> getProducts() {
        return products;
    }

    public void setProducts(List<Product> products) {
        this.products = products;
    }

    @Override
    public String toString() {
        return "Category{" + "categoryId=" + categoryId + ", categoryName=" + categoryName + ", categoryDescp=" + categoryDescp + '}';
    }
    
    
}
