def  fibonacci_gen(n):
    l=list(range(n))
    i=0
    for c in l:
        i=i+1
        if i<2:   continue
        elif i>n: break
        else:
            k=int(l[i-2])+int(l[i-1])
            l.insert(i,k)
        if i<n: l.pop()
    return l

n = 15
for num in fibonacci_gen(n):
    print(num)

"""
def  fibonacci_gen(n):
    m=abs(n)
    l=list(range(m))
    i=0
    for c in l:
        i=i+1
        
        if i<2:   continue
        elif i>m: break
        else:
            k=int(l[i-2])+int(l[i-1])
            if (n<0 and (i-1)%2):
                   print('-'+str(i))
     
            l.insert(i,k)

        if i<m: l.pop()

    return l

n = -10
for num in fibonacci_gen(n):
    print(num)

print('------')
t=5%2
t=abs(-5)
t=-1*t
print(t)

n = int(input("Введите Число Фибоначчи  n="))
l=list(range(n))

print(l)

if n > 10:
    print('big')
elif  n <= 10 and n>=5:
    print('medium')
else:
    print('small')

print('--------')

for i in 'hello':
    print(i,end='_')
    print(i*2,end='+')

c=[c*3 for c in 'liat']
print(c)

print('--------')
c.insert(1,3)
print(c)

print('--------')
"""


