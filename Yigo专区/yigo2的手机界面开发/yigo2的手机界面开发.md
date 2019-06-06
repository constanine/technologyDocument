## YIGO2的手机界面开发

#### 1. 所有在界面中使用`yigo2`的操作.需要依赖`yes-platform`模块

#### 2. `yes-platform`的模块实现是可以替换的,在`src/config/webpack.config.js`中定义了`alias`属性方便切换。默认`yes-platform`的实现为`yes-web`模块

```javascript
    ...
    resolve: {
        extensions: ['.js', '.web.js'],
        alias: {
            'react-native': 'react-native-web',
            'yes-platform': 'yes-web',
             yes: 'yes-intf',
        },
    },
    ...
```

#### 3. 页面的内容切换,使用`History.push()`方法,在使用`History.push('card/***'）`之后的调用过程,可以跟踪`src/route/index.js`,根据部分代码可见

```javascript
const defaultCardRoute = {
    DynamicDetail: {
        screen: withNavigation(DynamicView),
        path: 'YESMOBILE/:metaKey/:id/:status',
    },
    DynamicDetail1: {
        screen: withNavigation(DynamicView),
        path: 'YES/:metaKey/:id/:status',
    },
    Workitem: {
        screen: withNavigation(WorkitemView),
        path: 'WORKITEM/:wid/:onlyOpen/:loadInfo',
    },
    WorkitemM: {
        screen: withNavigation(WorkitemView),
        path: 'WORKITEMM/:wid/:onlyOpen/:loadInfo/:msg',
    },
    WorkitemField: {
        screen: withNavigation(FieldView),
        path: 'WORKITEM/:wid/:field',
    },
};
```
|push路径|对应模板|
| :-------- | :------- |
|`History.push('YESMOBILE/:metaKey/:id/:status'）`|`src/DynamicView.js`|
|`History.push('YES/:metaKey/:id/:status'）`|`src/DynamicView.js`|
|`History.push('WORKITEM/:wid/:onlyOpen/:loadInfo'）`|`src/WorkitemView.js`|
|`History.push('WORKITEMM/:wid/:onlyOpen/:loadInfo/:msg'）`|`src/WorkitemView.js`|
|`History.push('WORKITEM/:wid/:field'）`|`src/FieldView.js`|


#### 4. 针对最常用的`History.push('card/YES/${metaKey}/${id}/${status}')`解说下参数含义
   - metaKey 表单的key，这个就是yigo2的form对象key 
   - id
     - 如果是具体单据就是单据的OID
     - 如果是序时簿或多样式表单,则直接使用-1
     - 如果是单据新增,则直接使用new
   - status 操作状态,如编辑,或者新建,或者载入

#### 5. 登入后的主页展示修改
   - 修改 `src/controls/Home.js`文件中`Home.render()`部分,对于return的json结构就是展示登入后的个人主页展示部分
   - `Home.render()`的返回结果,请按照vue.js的规则去开发编写

#### 6. 如何添加展示yigo2的目标单据
   - `src/controls/Home.js`中,render的·view-body·添加显示以及`History.push('card/YES/${metaKey}/${id}/${status}')`,如:

    ```javascript
    export default class Home extends Component {
        render() {
            return (
                ...
                <View style={styles.view}>
                    <View style={styles.listItem}>
                    <Button onPress={this._onPressButton} title="人员" />
                    </View>
                </View>
                ...
            )
        }     
        _onPressButton(){
            History.push('card/YES/T001WorkLogView/-1/EDIT')
        }
    }
    ```
   - 在`src/config/billforms`中添加以`formkey`为文件名的json文件
   - 在`src/config/billforms/index.js`中添加,`import`依赖，同时在default中添加改formkey,一下是`git diff`的结果
     ```shell
        diff --git a/src/config/billforms/index.js b/src/config/billforms/index.js
        index b5672e8..e28690b 100644
        --- a/src/config/billforms/index.js
        +++ b/src/config/billforms/index.js
        @@ -1,7 +1,9 @@
         import defaultForm from './default.json';
         import SD_SaleOrder from './SD_SaleOrder.json';
        +import T001WorkLogView from './T001WorkLogView.json';

         export default {
             default: defaultForm,
             SD_SaleOrder,
        +    T001WorkLogView,
         };
     ```

   - 在`src/FormPara/zh-CN.json`添加改form的单元
      ```shell
        diff --git a/src/FormPara/zh-CN.json b/src/FormPara/zh-CN.json
        index c42a551..4eddb9a 100644
        --- a/src/FormPara/zh-CN.json
        +++ b/src/FormPara/zh-CN.json
        @@ -4,6 +4,9 @@
                     "WorkflowTypeDtlID": 4361395
                 },
                 "title": "请假单"
        +    },
        +    "T001WorkLogView": {
        +
             },
             "B_TravelExpenseApply": {
                 "title": "差旅(探亲)申请单"
        ...
     ```

#### 7. 在开发时,切换访问的数据提供源,src/config/project.json,这个已在https://github.com/jefferscn/yes-framework/wiki声明,不在过多描述

#### 8. 如何做打开即登入的动作,参考https://github.com/jefferscn/yes-framework/wiki/认证模块开发

   - 重点1 在`src/config.js`中添加

     ```
     appOptions.authenticatedRoute = WechatSSOAuthenticatedRoute //这个未自定义认证模块
     ```
   - 重点2 在自定义认证模块中,凡是想使用`await`来做到时序性的，必须在方法上修饰为`async`且记得方法前需要`const`来修饰,这些参照ES6准则,
   - 重点3 基于ES6,service模式不在使用ajax,而是使用fetch函数,且开启`credentials`模式,保证后台可以更改`cookie`,如
     ```javascript
      const resp = await fetch(`${Svr.SvrMgr.ServletURL}/../wechat/sso/5`, {credentials: 'include' });
      const result = await resp.json();
     ```

