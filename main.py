#read file

with open('name.txt') as name_file:
    test = name_file.readlines()


#make integer list

inte = []

for index,i in enumerate(test):
    inte.insert(index,i[1:])

for index,i in enumerate(inte):
    inte[index] = int(inte[index])

#results

final_values = [50]
inc = 0

#temp_var1 = final_values[0]

for index,i in enumerate(test):
    temp_var1 = final_values[index]
    if i[0] == 'R':
        for j in range(inte[index]):
            temp_var1 = temp_var1 + 1
            #print(temp_var1)
            if temp_var1 == 100:
                #print(temp_var1)
                inc = inc + 1
                temp_var1 = 0
    if i[0] == 'L':
        for j in range(inte[index]):
            temp_var1 = temp_var1 - 1
            '''
            if temp_var1 == -1:
                inc = inc + 1
                temp_var1 = 99
            '''
            if temp_var1 == 0:
                inc = inc + 1
            if temp_var1 == -1:
                temp_var1 = 99
    final_values.insert(index+1, temp_var1)
    

#output

idk = 50
for j in range(1):
    idk = idk - 1
    print(idk)

print(final_values[1])
print(test[0][0])
print(inte[0])
print(inc)