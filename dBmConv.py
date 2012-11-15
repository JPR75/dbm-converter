# dBm to volt and volt to dBm converter
# 50 Ohm load
# License: LGPLv3

from tkinter import *
from math    import log10, sqrt

################################################################################
# Get the input value
################################################################################
def convert (event) :
  try :
    val = eval(entryField.get())
    if convChoice.get() == 1 :
      convertedValue = "{:.3f} V pk-pk <=> {:.3f} dBm"
      result.configure(text = convertedValue.format(val, 10.0 * log10(val**2 * 2.5)))
    elif convChoice.get() == 2 :
      convertedValue = "{:.3f} V rms <=> {:.3f} dBm"
      result.configure(text = convertedValue.format(val, 10.0 * log10(val**2 * 20)))
    elif convChoice.get() == 3 :
      convertedValue = "{:.3f} dBm <=> {:.3f} V pk-pk"
      result.configure(text = convertedValue.format(val, sqrt(0.4 * 10**(val / 10.0))))
    elif convChoice.get() == 4 :
      convertedValue = "{:.3f} dBm <=> {:.3f} V rms"
      result.configure(text = convertedValue.format(val, sqrt(0.05 * 10**(val / 10.0))))
    else :
      result.configure(text = 'Unexpected convertion, error in soft !')
  except :
    result.configure(text = 'Bad value, try a number or a voltage differant of 0V!')

################################################################################
################################  Main  ########################################
################################################################################
convWindows = Tk()
convWindows.title('Volt <=> dBm ; v1.0.0')

# Title and version
Label(convWindows, text = 'Volt to dBm convertor on a 50 Ohm load').grid(row  = 0, column = 0, columnspan = 2, padx = 10)

# Radio buttons
convChoice = IntVar()
R1 = Radiobutton(convWindows, text = "V pk-pk to dBm", variable = convChoice, value=1)
R1.grid(row = 2, column = 0, sticky = W, padx = 10 , pady = 5)
R1.select()
R2 = Radiobutton(convWindows, text = "V rms to dBm", variable = convChoice, value=2)
R2.grid(row = 3, column = 0, sticky = W, padx = 10)
R3 = Radiobutton(convWindows, text = "dBm to V pk-pk", variable = convChoice, value=3)
R3.grid(row = 2, column = 1, sticky = W, padx = 10 , pady = 5)
R4 = Radiobutton(convWindows, text = "dBm to V rms", variable = convChoice, value=4)
R4.grid(row = 3, column = 1, sticky = W, padx = 10)

# Value entry
entryField = Entry(convWindows)
entryField.bind("<Return>", convert)
entryField.grid(row = 4, column = 0, columnspan = 2, padx = 10 , pady = 5)

# Print result
result = Label(convWindows, text = 'xxx <=> yyy', relief = GROOVE, bg = '#F0F0E0', bd = 2)
result.grid(row = 5, column = 0, columnspan = 2, padx = 10, pady = 5)

# Perform calculation button
Button(convWindows, text = 'Convert', command = lambda : convert('0')).grid(row = 6, column = 0, pady = 5)

# Quit button
Button(convWindows, text='Quit', command = convWindows.destroy).grid(row = 6, column = 1, pady = 5)

convWindows.mainloop()
