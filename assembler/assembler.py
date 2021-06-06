import re


in_file_name = "TowOperand.asm"
out_file_name = in_file_name.split('.')[0] + ".mem"
mem_size = 2**16  # words
word_size = 16
memory = ["0"*16 for _ in range(mem_size)]
current_location = 0
print(out_file_name)

# *opcode* ->  opcode bits
# *rdst* -> Rdst bits
# *rsrc* -> rsrc bits
# *shamd* -> shift amount
dic_category_format = {
    'one-operand': "00*opcode*00*rdst*00000",
    'tow-operand': "01*opcode**rsrc**rdst**shamd*",  # can have immediate value
    'memory': "10*opcode**rsrc**rdst*00000",
    'branch': "11*opcode*000*rdst*00000",
}
operations_db = {
    "nop": {
        'type': 'one-operand',
        'opcode': '0000'
    },
    "setc": {
        'type': 'one-operand',
        'opcode': '0001'
    },
    "clrc": {
        'type': 'one-operand',
        'opcode': '0010'
    },
    "clr": {
        'type': 'one-operand',
        'opcode': '0011'
    },
    "not": {
        'type': 'one-operand',
        'opcode': '0100'
    },
    "inc": {
        'type': 'one-operand',
        'opcode': '0101'
    },
    "dec": {
        'type': 'one-operand',
        'opcode': '0110'
    },
    "neg": {
        'type': 'one-operand',
        'opcode': '0111'
    },
    "out": {
        'type': 'one-operand',
        'opcode': '1000'
    },
    "in": {
        'type': 'one-operand',
        'opcode': '1001'
    },
    "rlc": {
        'type': 'one-operand',
        'opcode': '1010'
    },
    "rrc": {
        'type': 'one-operand',
        'opcode': '1011'
    },
    "mov": {
        'type': 'tow-operand',
        'opcode': '000',
        'imm': False,
        'shamd': False,
    },
    "add": {
        'type': 'tow-operand',
        'opcode': '001',
        'imm': False,
        'shamd': False,
    },
    "sub": {
        'type': 'tow-operand',
        'opcode': '010',
        'imm': False,
        'shamd': False,
    },
    "and": {
        'type': 'tow-operand',
        'opcode': '011',
        'imm': False,
        'shamd': False,
    },
    "or": {
        'type': 'tow-operand',
        'opcode': '100',
        'imm': False,
        'shamd': False,
    },
    "iadd": {
        'type': 'tow-operand',
        'opcode': '101',
        'imm': True,
        'shamd': False,
    },
    "shl": {
        'type': 'tow-operand',
        'opcode': '110',
        'imm': False,
        'shamd': True,
    },
    "shr": {
        'type': 'tow-operand',
        'opcode': '111',
        'imm': False,
        'shamd': True,
    },
    "push": {
        'type': 'memory',
        'opcode': '000',
        'imm': False,
        'offset': False
    },
    "pop": {
        'type': 'memory',
        'opcode': '001',
        'imm': False,
        'offset': False
    },
    "ldm": {
        'type': 'memory',
        'opcode': '010',
        'imm': True,
        'offset': False
    },
    "ldd": {
        'type': 'memory',
        'opcode': '011',
        'imm': True,
        'offset': True
    },
    "std": {
        'type': 'memory',
        'opcode': '100',
        'imm': True,
        'offset': True
    },
    "jz": {
        'type': 'branch',
        'opcode': '000',
    },
    "jn": {
        'type': 'branch',
        'opcode': '001',
    },
    "jc": {
        'type': 'branch',
        'opcode': '010',
    },
    "jmp": {
        'type': 'branch',
        'opcode': '011',
    },
    "call": {
        'type': 'branch',
        'opcode': '100',
    },
    "ret": {
        'type': 'branch',
        'opcode': '101',
        'parameter': False,
    },
    "rti": {
        'type': 'branch',
        'opcode': '110',
        'parameter': False,
    }

}


def splitString(string, sep=" "):
    strArr = string.split(sep)
    modified_arr = []
    for string in strArr:
        temp = string.strip()
        if temp != "":
            modified_arr.append(temp)
    return modified_arr


def binarize(num, word_size=16):
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
            else:
                if operations_db[inst_parts[0]]['type'] == 'one-operand':
                    print("one operand")
                    rdst = "000"
                    registers = re.findall("r\d+", instruction)
                    if(len(registers) != 0):
                        rdst = binarize(int(registers[0][1:]), 3)
                    binary_code = dic_category_format['one-operand']
                    binary_code = binary_code.replace('*rdst*', rdst)
                    binary_code = binary_code.replace(
                        '*opcode*', operations_db[inst_parts[0]]['opcode'])
                    print(instruction, binary_code,
                          dic_category_format['one-operand'], rdst)
                    # add to memory
                    memory[current_location] = binary_code
                    current_location += 1

                elif operations_db[inst_parts[0]]['type'] == 'tow-operand':
                    print("tow operand")
                    rdst = "000"
                    rsrc = "000"
                    shamd = "00000"
                    immediate = "x"*16
                    registers = re.findall("r\d+", instruction)

                    rdst = binarize(int(registers[0][1:]), 3)
                    values = splitString(inst_parts[1], ',')
                    if operations_db[inst_parts[0]]['imm']:
                        immediate = binarize(int(values[1], 16), word_size)
                    elif operations_db[inst_parts[0]]['shamd']:
                        shamd = binarize(int(values[1]), 5)
                    else:
                        rsrc = binarize(int(registers[1][1:], 16), 3)

                    binary_code = dic_category_format['tow-operand']
                    binary_code = binary_code.replace('*rdst*', rdst)
                    binary_code = binary_code.replace('*rsrc*', rsrc)
                    binary_code = binary_code.replace('*shamd*', shamd)
                    binary_code = binary_code.replace(
                        '*opcode*', operations_db[inst_parts[0]]['opcode'])
                    print(instruction, binary_code,
                          dic_category_format['tow-operand'], rdst, rsrc, shamd, immediate)
                    # add to memory
                    memory[current_location] = binary_code
                    current_location += 1
                    if operations_db[inst_parts[0]]['imm']:
                        memory[current_location] = immediate
                        current_location += 1

                elif operations_db[inst_parts[0]]['type'] == 'memory':
                    print("memory")
                    # 'memory': "10*opcode**rsrc**rdst*00000",
                    rdst = "000"
                    rsrc = "000"
                    immediate = "x"*16
                    registers = re.findall("r\d+", instruction)
                    rdst = binarize(int(registers[0][1:], 16), 3)

                    values = splitString(inst_parts[1], ',')
                    if operations_db[inst_parts[0]]['imm'] and operations_db[inst_parts[0]]['offset']:
                        # LDD, STD
                        # STD R1,202(R5)   #M[212]=19
                        # LDD R3,202(R5)   #R3=19
                        rsrc = binarize(int(registers[1][1:]), 3)
                        new_values = splitString(values[1], "(")
                        immediate = binarize(int(new_values[0]), word_size)

                    elif operations_db[inst_parts[0]]['imm'] and not(operations_db[inst_parts[0]]['offset']):
                        # LDM
                        # LDM R1,5     #R1=5
                        immediate = binarize(int(values[1]), word_size)

                    elif not(operations_db[inst_parts[0]]['imm']) and not(operations_db[inst_parts[0]]['offset']):
                        # push
                        pass
                    else:
                        # error
                        raise RuntimeError(
                            "unexpcted: implementation error consult marait")

                    binary_code = dic_category_format['memory']
                    binary_code = binary_code.replace('*rdst*', rdst)
                    binary_code = binary_code.replace('*rsrc*', rsrc)
                    binary_code = binary_code.replace(
                        '*opcode*', operations_db[inst_parts[0]]['opcode'])
                    print(instruction, binary_code,
                          dic_category_format['memory'], rdst, rsrc, immediate)
                    memory[current_location] = binary_code
                    current_location += 1
                    if operations_db[inst_parts[0]]['imm'] or operations_db[inst_parts[0]]['offset']:
                        memory[current_location] = immediate
                        current_location += 1

                else:  # branch
                    rdst = "000"
                    rsrc = "000"
                    immediate = "x"*16
                    registers = re.findall("r\d+", instruction)
                    if(len(registers) == 1):
                        rdst = binarize(int(registers[0][1:], 16), 3)

                    binary_code = dic_category_format['branch']
                    binary_code = binary_code.replace('*rdst*', rdst)
                    binary_code = binary_code.replace(
                        '*opcode*', operations_db[inst_parts[0]]['opcode'])
                    print(instruction, binary_code,
                          dic_category_format['branch'], operations_db[inst_parts[0]]['opcode'], rdst, immediate)
                    memory[current_location] = binary_code
                    current_location += 1
        print("instruction: *" + instruction + '*')
print("memory is written to " + out_file_name)
# [print(i, ":", hex(i), "=>", val) for i, val in enumerate(memory)]
metadata = """
// memory data file (do not edit the following line - required for mem load use)
// instance=/ram/ram
// format=bin addressradix=h dataradix=b version=1.0 wordsperline=1
"""
with open(out_file_name, "w") as out_file:
    out_file.write(metadata)
    for i, val in enumerate(memory):
        out_file.write("@"+hex(i)[2:]+" "+val+'\n')
