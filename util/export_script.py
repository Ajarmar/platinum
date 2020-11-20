import sys

def main():
    try:
        with open(sys.argv[1],'rb') as f:
            script_base = int(sys.argv[2],base=16)
            if script_base > 0x08000000:
                script_base = script_base - 0x08000000
            f.seek(script_base)
            opcode = read_byte(f)
            while opcode != 0xFF:
                print_hex_byte(opcode,endsymbol=' ',prefix='')
                for i in range(7):
                    arg = read_byte(f)
                    print_hex_byte(arg,endsymbol=' ',prefix='')
                print("")
                opcode = read_byte(f)
            print_hex_byte(opcode,endsymbol=' ',prefix='')
            for i in range(7):
                arg = read_byte(f)
                print_hex_byte(arg,endsymbol=' ',prefix='')
            print("\nEnd: 0x08",end='')
            print_hex(f.tell(),prefix='')
    except IndexError:
        print("Error: No file specified")
        sys.exit(2)
    except IOError:
        print("Error: File does not exist")
        sys.exit(2)

def print_hex(hex_value,endsymbol='\n',prefix='0x'):
    print(prefix + "{:X}".format(hex_value),end=endsymbol)
    
def print_hex_byte(hex_value,endsymbol='\n',prefix='0x'):
    print(prefix + "{:0>2X}".format(hex_value),end=endsymbol)
    
def print_hex_word(hex_value,endsymbol='\n',prefix='0x'):
    print(prefix + "{:0>8X}".format(hex_value),end=endsymbol)
    
def read_byte(file):
    return int.from_bytes(file.read(1),byteorder='little')
    
def read_halfword(file):
    return int.from_bytes(file.read(2),byteorder='little')
    
def read_word(file):
    return int.from_bytes(file.read(4),byteorder='little')
    
if __name__ == "__main__":
    main()