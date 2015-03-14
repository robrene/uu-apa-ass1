import CCO.Component  (ioWrap, printer)
import CCO.Tree       (fromTree)
import Parser.Parser  (parser)
import Control.Arrow  (arr, (>>>))

main = ioWrap (arr parser >>> arr fromTree >>> printer)
