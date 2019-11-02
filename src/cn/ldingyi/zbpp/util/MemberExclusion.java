package cn.ldingyi.zbpp.util;

import com.google.gson.ExclusionStrategy;
import com.google.gson.FieldAttributes;

public class MemberExclusion implements ExclusionStrategy {

    @Override
    public boolean shouldSkipField(FieldAttributes fieldAttributes) {
        if (fieldAttributes.getName().equals("members")){
            return true;
        }
        return false;
    }

    @Override
    public boolean shouldSkipClass(Class<?> aClass) {

        return false;
    }
}
