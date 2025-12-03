#read file

with open('name.txt') as name_file:
    test = name_file.readlines()


#make integer list

inte = []

for index,i in enumerate(test):
    inte.insert(index,i[1:])

#integer list fix

for index,i in enumerate(inte):
    inte[index] = int(inte[index])

def val_fix(val):
    while val > 99:
        val = val - 100
    #print(val)
    return val

for index,i in enumerate(inte):
    if i > 99:
        inte[index] = val_fix(i)

#final value list

results = [50]

for index,i in enumerate(test):
    if i[0] == 'R':
        results.insert(index + 1,results[index] + inte[index])
        if results[index + 1] > 99:
            results[index+1] = results[index+1] - 100
    if i[0] == 'L':
        results.insert(index + 1,results[index] - inte[index])
        if results[index + 1] < 0:
            results[index+1] = results[index+1] + 100


#check # of zeros

inc = 0

for i in results:
    if i == 0:
        inc = inc + 1

print(inc)

#output

#print(results)

print(test[1][1:])
print(inte[101])
#print(min(inte))
print(max(inte))
val_fix(1053)