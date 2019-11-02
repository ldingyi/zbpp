package cn.ldingyi.zbpp.serviceImpl;

import org.springframework.data.jpa.repository.JpaRepository;
import cn.ldingyi.zbpp.service.BaseService;

import java.util.*;

public abstract class BaseServiceImpl<T> implements BaseService<T> {


    public abstract JpaRepository<T,Integer> getDAO();




   public int[] getIds(int[] ids, int isAll ,Set<Integer> allIds){
       if (isAll==0){
           return ids;
       }else {
           Set<Integer> result = new HashSet<>();
           Set<Integer> exceptIds = new HashSet<>();
           for (int i =0 ;i<ids.length;i++){
               exceptIds.add(ids[i]);
           }

           result.addAll(allIds);
           result.removeAll(exceptIds);
           Integer[] realIds = new Integer[result.size()];
           result.toArray(realIds);
           return Arrays.stream(realIds).mapToInt(Integer::intValue).toArray();
       }

    }

}

