```java
git checkout -b main
# Switched to a new branch 'main'
git branch
# * main
#  master
git merge master # 将master分支合并到main上
# Already up to date.
git pull origin main --allow-unrelated-histories # git pull origin main会报错：refusing to merge unrelated histories
git push origin main


```

关于不同操作系统之间换行符不同导致的警告：

The file will have its original line endings in your working directory.
warning: LF will be replaced by CRLF in mw_server4/static/forTest/world.js.
The file will have its original line endings in your working directory.

```java
git branch -M main
git rm -r --cached .
git config core.autocrlf false
git add .
git commit -m ""
git pull
git push -u origin main
```

