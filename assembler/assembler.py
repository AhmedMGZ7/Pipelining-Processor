in_file_name = "OneOperand.asm"
out_file_name = in_file_name.split('.')[0] + ".mem"
mem_size = 100  # words
word_size = 16
memory = ["0"*16 for i in range(mem_size)]
current_location = 0
print(out_file_name)


def splitString(string, sep=" "):
    strArr = string.split(sep)
    modified_arr = []
    for string in strArr:
        temp = string.strip()
        if temp != "":
            modified_arr.append(temp)
    return modified_arr


def binarize(num, word_size=word_size):
    bin_num = bin(num)[2:]
    bin_num = '0' * (word_size-len(bin_num)) + bin_num
    return bin_num


with open(in_file_name, "r") as in_file:
    lines = in_file.readlines()
    instruction = ""
    for line in lines:
        line = line.replace('\n', '')
        line = line.strip()
        # if the line is empty ignore
        if line == "":
            # print("empty line")
            continue
        elif line.find("#") != -1:
            comment_line = line.split("#")
            # print("before comm ", comment_line[0], " after", comment_line[1])
            instruction = comment_line[0].strip()
            if instruction == "":
                continue
        else:
            instruction = line
        instruction = instruction.lower()
        inst_parts = splitString(instruction, " ")
        if inst_parts[0].find("org") != -1:
            assert len(inst_parts) == 2
            current_location = int(inst_parts[1])
            print("inst:", inst_parts[0], " location:", current_location)
        else:
            if(instruction.isnumeric()):
                memory[current_location] = binarize(
                    int(instruction), word_size)
                current_location += 1
        print("instruction: ", instruction)
print("memory is ")
print(memory)
