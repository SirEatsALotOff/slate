::book_writer
@echo off
cls
:main
cls
echo This program is a brilliant book writer that will run until your computer dies!
pause
cls
set x=0
:loop
cls
set /a x=%x%+1
echo 'Darian once created a book, it said >>BestSellingBook.txt
echo %x% lines written!
goto loop