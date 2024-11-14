
-- Formatting

-- Can select not using table

select 5 + 3 as 'Eight', 'hej' as 'Hej';

-- FORMAT(value to format, formatting ruleset, culture info)

-- Standard numeric format strings

-- C = Currency
select FORMAT(0.75, 'C', 'sv-SE')

-- F = Fixed point. 
-- C# Equivalent: myInt.ToString("F3");
-- $"{myInt:F3}"

select FORMAT(1234.567, 'F1')
select FORMAT(1234.567, 'F') -- = 2 decimals

-- P = Percentage
select FORMAT(0.75, 'P')

-- X  = Hexadecimal
select FORMAT(255, 'x') -- lower case letters
select FORMAT(255, 'X') -- upper case letters
select FORMAT(255, 'X8') -- number of letters/numbers

-- Custom numeric format strings
-- Rounds values

-- 0 = Zero placeholder
select FORMAT(123.456, '00.00') -- 123.46
select FORMAT(123.456, '0000.0000') -- 0123.4560

-- # = Number placeholder
select FORMAT(123.456, '##.##') -- 123.46
select FORMAT(123.456, '####.####') -- 123.456