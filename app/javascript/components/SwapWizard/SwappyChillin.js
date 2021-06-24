import React, { useState, useEffect } from 'react'
import { TimelineLite } from 'gsap'
import { TimelineMax } from 'gsap'
import SwappyBlink from 'images/swappy-blink.png'
import SwappyAwake from 'images/swappy-awake.png'

const SwappyChillin = (props) => {
  const [tl] = useState(
    new TimelineLite({
      onComplete: function () {
        this.restart()
      },
    })
  )

  let tweenTarget = null

  useEffect(() => {
    tl.to(tweenTarget, 0.75, {})
      .set(tweenTarget, { attr: { src: SwappyBlink } })
      .to(tweenTarget, 0.5, {})
      .set(tweenTarget, { attr: { src: SwappyAwake } })
      .to(tweenTarget, 0.12, {})
      .set(tweenTarget, { attr: { src: SwappyBlink } })
      .to(tweenTarget, 0.22, {})
      .set(tweenTarget, { attr: { src: SwappyAwake } })
      .to(tweenTarget, 0.7, {})
  }, [])

  return (
    <img
      id="swappy"
      className="w-full"
      ref={(e) => (tweenTarget = e)}
      src={SwappyAwake}
    />
  )
}

export default SwappyChillin
