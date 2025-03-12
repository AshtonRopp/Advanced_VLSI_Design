def int_to_signed_binary(num, bits=32):
    # Handle the case for negative numbers by converting them to two's complement
    if num < 0:
        # Two's complement conversion for negative numbers
        num = (1 << bits) + num  # Add 2^bits to the number
    # Format the number as a signed binary string
    return format(num, f'0{bits}b')  # Ensure the binary string is `bits` long

# List of numbers
numbers = [
    -503524, -1890226, -4979597, -10625992, -19534716, -31897586,
    -47029310, -63130666, -77321328, -86037964, -85794376, -74168423,
    -50760427, -17804280, 19851701, 55534092, 82217350, 94351153,
    89532901, 69480321, 39899711, 9149420, -14022239, -23043559,
    -15599634, 5492156, 32996881, 57458657, 70257434, 66559117,
    47147262, 18425901, -9538556, -26397842, -25244497, -5387713,
    26878433, 59959737, 80722339, 79194170, 52650844, 7611173,
    -41138873, -74436580, -74508942, -30879372, 55483563, 171219331,
    293325340, 394949726, 452592558, 452592558, 394949726, 293325340,
    171219331, 55483563, -30879372, -74508942, -74436580, -41138873,
    7611173, 52650844, 79194170, 80722339, 59959737, 26878433,
    -5387713, -25244497, -26397842, -9538556, 18425901, 47147262,
    66559117, 70257434, 57458657, 32996881, 5492156, -15599634,
    -23043559, -14022239, 9149420, 39899711, 69480321, 89532901,
    94351153, 82217350, 55534092, 19851701, -17804280, -50760427,
    -74168423, -85794376, -86037964, -77321328, -63130666, -47029310,
    -31897586, -19534716, -10625992, -4979597, -1890226, -503524
]

# Open a file to save the signed binary numbers
with open("signed_binary_numbers.txt", "w") as file:
    # Convert each number to signed binary and write to the file
    for number in numbers:
        signed_binary = int_to_signed_binary(number)
        file.write(signed_binary + "\n")

