in_file_name = "OneOperand.asm"
out_file_name = in_file_name.split('.')[0] + ".mem"
mem_size = 100  # words


print(out_file_name)
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
        print("instruction: ", instruction)
