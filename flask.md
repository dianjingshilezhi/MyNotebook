## 1: flask传递URL

```Python
方法一：
@app.route('/get_resource<name>', methods=['GET'])
def get_instance(name):
    print(name)
    instances = api_example.list_servers()
    pass


$.get("/get_resource/"+properties, function (data) {
                let instances = JSON.parse(data)
})
方法二传值：
@app.route('/user',methods=['GET','POST'])
def user():
    #判断请求方式为POST否则为GET
    if request.method == 'POST':
        name=request.form.get('name', 'default value')#参数不存在时默认default value
        print('name:%s' % (name))
    else:
        name = request.args.get('name', 'default value')#参数不存在时默认default value
        print('name:%s' % (name))
    return jsonify({'Success': "1"})
if __name__ == '__main__':
    app.run(host="0.0.0.0",port=int("8999"))`
   
$.get("/user",{name:'zy'} function (data) {
                
})
```

# 