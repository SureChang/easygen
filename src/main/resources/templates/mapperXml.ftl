<?xml version="1.0" encoding="UTF-8" ?>
<!DOCTYPE mapper PUBLIC "-//mybatis.org//DTD Mapper 3.0//EN" "http://mybatis.org/dtd/mybatis-3-mapper.dtd" >
<mapper namespace="${options.mapperns}.${model.upperCaseName}Mapper">
    <resultMap id="BaseResultMap" type="${options.pons}.${model.upperCaseName}">
        <id column="${model.primaryKey.name}" property="${model.primaryKey.name}" jdbcType="${model.primaryKey.typeName}"/>
    <#list model.fields as field>
        <result column="${field.name}" property="${field.name}" jdbcType="${field.typeName}"/>
    </#list>
    </resultMap>
    <sql id="Base_Column_List">
        <#list model.fields as field>${field.name}<#sep>, </#list>
    </sql>
    <select id="selectAll" resultMap="BaseResultMap">
        select
        <include refid="Base_Column_List"/>
        from ${model.name}
    </select>
    <select id="selectByPrimaryKey" resultMap="BaseResultMap" parameterType="java.lang.Integer">
        select
        <include refid="Base_Column_List"/>
        from ${model.name}
        where id = ${r"#{"}${model.primaryKey.name},jdbcType=${model.primaryKey.typeName}${r"}"}
    </select>
    <delete id="deleteByPrimaryKey" parameterType="java.lang.Integer">
        delete from ${model.name}
        where id = ${r"#{"}${model.primaryKey.name},jdbcType=${model.primaryKey.typeName}${r"}"}
    </delete>
    <insert id="insert" useGeneratedKeys="true" keyProperty="${model.primaryKey.name}" parameterType="${options.pons}.${model.upperCaseName}">
        insert into ${model.name} (<#list model.fields as field>${field.name}<#sep>, </#list>)
        values (<#list model.fields as field>${r"#{"}${field.name},jdbcType=${field.typeName}${r"}"}<#sep>, </#list>)
    </insert>
    <insert id="insertSelective" useGeneratedKeys="true" keyProperty="${model.primaryKey.name}" parameterType="${options.pons}.${model.upperCaseName}">
        insert into ${model.name}
        <trim prefix="(" suffix=")" suffixOverrides=",">
        <#list model.fields as field>
            <if test="${field.name} != null">
            ${field.name},
            </if>
        </#list>
        </trim>
        <trim prefix="values (" suffix=")" suffixOverrides=",">
        <#list model.fields as field>
            <if test="${field.name} != null">
            ${r"#{"}${field.name},jdbcType=${field.typeName}${r"}"},
            </if>
        </#list>
        </trim>
    </insert>
    <update id="updateByPrimaryKeySelective" parameterType="${options.pons}.${model.upperCaseName}">
        update ${model.name}
        <set>
        <#list model.fields as field>
            <#if field.name != model.primaryKey.name>
            <if test="${field.name} != null">
            ${field.name} = ${r"#{"}${field.name},jdbcType=${field.typeName}${r"}"},
            </if>
            </#if>
        </#list>
        </set>
        where id = ${r"#{"}${model.primaryKey.name},jdbcType=${model.primaryKey.typeName}${r"}"}
    </update>
    <update id="updateByPrimaryKey" parameterType="${options.pons}.${model.upperCaseName}">
        update ${model.name}
        set
    <#list model.fields as field>
        <#if field.name != model.primaryKey.name>
        ${field.name} = ${r"#{"}${field.name},jdbcType=${field.typeName}${r"}"}<#sep>,
        </#if>
    </#list>

        where id = ${r"#{"}${model.primaryKey.name},jdbcType=${model.primaryKey.typeName}${r"}"}
    </update>
</mapper>