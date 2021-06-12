import React, { useState, useEffect } from 'react'
import { TimelineLite } from 'gsap'
import SwappySleep from 'images/swappy-sleep.png'
import SwappyYawn from 'images/swappy-yawn.png'
import SwappyBlink from 'images/swappy-blink.png'
import SwappyAwake from 'images/swappy-awake.png'

const SwappyAnimation = (props) => {
  const [tl] = useState(new TimelineLite({ paused: false }))

  let tweenTarget = null

  useEffect(() => {
    tl.to(tweenTarget, 1, {})
      .set(tweenTarget, { attr: { src: SwappyYawn } })
      .to(tweenTarget, 0.8, {})
      .set(tweenTarget, { attr: { src: SwappyBlink } })
      .to(tweenTarget, 0.5, {})
      .set(tweenTarget, { attr: { src: SwappyAwake } })
      .to(tweenTarget, 0.15, {})
      .set(tweenTarget, { attr: { src: SwappyBlink } })
      .to(tweenTarget, 0.25, {})
      .set(tweenTarget, { attr: { src: SwappyAwake } })
      .to(tweenTarget, 0.8, {})
      .add(props.advance)
  }, [])

  return (
    <div className="flex justify-center">
      <img id="swappy" ref={(e) => (tweenTarget = e)} src={SwappySleep} />
    </div>
  )
}

export default SwappyAnimation
