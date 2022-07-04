
package com.mycompany.organic.helper;

import java.util.HashMap;
import java.util.Map;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;


public class Helper {
    public static String get10Words(String descp)
    {
        String strs[] = descp.split(" ");
        if(strs.length > 10)
        {
       
            String res="";
            for(int i=0;i<10;i++)
            {
                res = res +strs[i]+" ";
                
            }
            return (res+"...");
        }
        else
        {
            return (descp+"...");
        }
        
    }
    
    public static Map<String, Long> getCounts(SessionFactory factory)
    {
        Session session = factory.openSession();
        String q1="Select count(*) from User";
        String q2="Select count(*) from Product";
        
        Query query1 = session.createQuery(q1);
        Query query2 = session.createQuery(q2);
        
        long usercount = (long) query1.list().get(0);
        long prodcount = (long) query2.list().get(0);
        
        Map<String,Long> map = new HashMap();
        map.put("UserCount", usercount);
        map.put("ProdCount", prodcount);
        
        session.close();
        return map;
    }
}
