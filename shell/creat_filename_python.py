import os
root = os.getcwd()
data = 'test'
path = os.listdir(root+'/'+data)
path.sort()
file = open('train.txt','w')
i = 0
for line in path:
    str = root+'/'+data+'/'+line
    for child in os.listdir(str):
        str1 = data+'/'+line+'/'+child;
        d = ' %s' %(i)
        t = str1 + d
        file.write(t +'\n')
    i=i+1

file.close()
