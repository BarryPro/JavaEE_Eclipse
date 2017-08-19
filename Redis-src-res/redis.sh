for r in "redis-2.0.4.tar.gz" "redis-2.0.5.tar.gz" "redis-2.2.0-rc2.tar.gz" "redis-2.2.0-rc3.tar.gz" "redis-2.2.0-rc4.tar.gz" \
    "redis-2.2.0.tar.gz" "redis-2.2.1.tar.gz" "redis-2.2.2.tar.gz" "redis-2.2.3.tar.gz" "redis-2.2.4.tar.gz" "redis-2.2.5.tar.gz" "redis-2.2.105-scripting.tar.gz" \
    "redis-2.2.6.tar.gz" "redis-2.2.106-scripting.tar.gz" "redis-2.2.7.tar.gz" "redis-2.2.107-scripting.tar.gz" "redis-2.2.8.tar.gz" "redis-2.2.9.tar.gz" "redis-2.2.10.tar.gz" "redis-2.2.10-scripting.tar.gz" "redis-2.2.110-scripting.tar.gz" "redis-2.2.11.tar.gz" "redis-2.2.111-scripting.tar.gz" \
    "redis-2.2.12.tar.gz" "redis-2.2.13.tar.gz" "redis-2.2.14.tar.gz" "redis-2.2.15.tar.gz" 
do
    dst="./../../../redis_code"
    p=`pwd`
    tar xvf $r
    d=${r%%.tar.gz}
    cd $d
    find . -type d -name ".svn" -o -name ".git" -o -name ".gitignore" | xargs rm -rf
    yes | cp -r * $dst
    cd $dst
    for s in `svn st | grep ?`
    do
        if test $s != "?"
        then
            svn add $s
        fi
    done
    v=${d##redis-}
    svn ci -m "$v"
    cd $p
    rm -rf $d
done
