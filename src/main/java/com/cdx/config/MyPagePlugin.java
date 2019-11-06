package com.cdx.config;

import com.cdx.util.PageUtil;
import org.apache.ibatis.executor.parameter.ParameterHandler;
import org.apache.ibatis.executor.statement.StatementHandler;
import org.apache.ibatis.plugin.*;
import org.apache.ibatis.reflection.DefaultReflectorFactory;
import org.apache.ibatis.reflection.MetaObject;
import org.apache.ibatis.reflection.SystemMetaObject;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.Map;
import java.util.Properties;

@Intercepts(@Signature(type = StatementHandler.class,method ="prepare",args = {Connection.class,Integer.class}))
public class MyPagePlugin implements Interceptor {

    String databaseType = "mysql";

    String pageSqlId = ".*List$";

    public String getDatabaseType() {
        return databaseType;
    }

    public void setDatabaseType(String databaseType) {
        this.databaseType = databaseType;
    }

    public String getPageSqlId() {
        return pageSqlId;
    }

    public void setPageSqlId(String pageSqlId) {
        this.pageSqlId = pageSqlId;
    }

    @Override
    public Object intercept(Invocation invocation) throws Throwable {
        StatementHandler statementHandler = (StatementHandler) invocation.getTarget();


        MetaObject metaObject = MetaObject.forObject(
                statementHandler, SystemMetaObject.DEFAULT_OBJECT_FACTORY,SystemMetaObject.DEFAULT_OBJECT_WRAPPER_FACTORY,new DefaultReflectorFactory());
        String sqlId = (String)metaObject.getValue("delegate.mappedStatement.id");
        //判断一下是否需要分页
        if (sqlId.matches(pageSqlId)){
            ParameterHandler parameterHandler = statementHandler.getParameterHandler();
            //原来的sql
            String sql = statementHandler.getBoundSql().getSql();
            //拿到数据库连接对象
            Connection connection = (Connection) invocation.getArgs()[0];
            String countSql = "select count(0) from ("+sql+") a";
            //渲染参数
            PreparedStatement preparedStatement = connection.prepareStatement(countSql);
            //条件交给mybatis
            parameterHandler.setParameters(preparedStatement);
            //执行sql
            ResultSet resultSet = preparedStatement.executeQuery();
            int count =0;
            if (resultSet.next()) {
                count = resultSet.getInt(1);
            }
            resultSet.close();
            preparedStatement.close();
            //获得传进来的参数对象
            Map<String, Object> parameterObject = (Map<String, Object>) parameterHandler.getParameterObject();
            PageUtil pageUtil = (PageUtil) parameterObject.get("page");
            //赋值总个数
            pageUtil.setCount(count);

            //拼接分页语句(limit) 并且修改mysql本该执行的语句
            String pageSql = getPageSql(sql, pageUtil);

            preparedStatement = connection.prepareStatement(pageSql);
            parameterHandler.setParameters(preparedStatement);
            metaObject.setValue("delegate.boundSql.sql",pageSql);
        }
        //推进拦截器调用链
        return invocation.proceed();
    }

    public String getPageSql(String sql,PageUtil pageUtil){
        if(databaseType.equals("mysql")){
            return sql+" limit "+pageUtil.getStart()+","+pageUtil.getLimit();
        }else if(databaseType.equals("oracle")){
            //拼接oracle的分语句
        }

        return sql+" limit "+pageUtil.getStart()+","+pageUtil.getLimit();
    }

    @Override
    public Object plugin(Object o) {
        return Plugin.wrap(o,this);
    }

    @Override
    public void setProperties(Properties properties) {

    }
}
