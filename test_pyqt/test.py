from PyQt5.QtWidgets import QApplication, QMainWindow
import PyQt5.QtWidgets as widgets
import sys


def window():
    win = QMainWindow()
    win.setGeometry(400, 400, 300, 300)
    win.setWindowTitle("PyQt5 Test")
    return win


def createView(win):
    label = widgets.QLabel(win)
    label.setText("Hello World")
    text = widgets.QTextEdit(win)
    text.setText("This is a text edit")
    text.setGeometry(0, 25, 150, 25)


if __name__ == "__main__":
    app = QApplication(sys.argv)
    win = window()

    createView(win)

    win.show()
    sys.exit(app.exec_())
