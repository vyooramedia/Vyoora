import easyocr

def warm():
    # instantiate once to download/cache weights in the image layer
    _ = easyocr.Reader(['en'], gpu=False)

if __name__ == "__main__":
    warm()
