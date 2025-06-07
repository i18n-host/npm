import postcss from "postcss";
import autoprefixer from "autoprefixer";
import postcssStyl from "postcss-styl";

export default (code, from) => {
  const css = postcss([autoprefixer]).process(code, {
    syntax: postcssStyl,
    from
  }).root.toString();
  return css;
}
