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
    tl.to(tweenTarget, 0.75, { opacity: 1 })
      .set(tweenTarget, { attr: { src: SwappyYawn } })
      .to(tweenTarget, 0.55, { y: -15, ease: 'elastic.out(1.2, 0.5' })
      .to(tweenTarget, 0.15, { y: 0, ease: 'power2.out' })
      .set(tweenTarget, { attr: { src: SwappyBlink } })
      .to(tweenTarget, 0.5, {})
      .set(tweenTarget, { attr: { src: SwappyAwake } })
      .to(tweenTarget, 0.12, {})
      .set(tweenTarget, { attr: { src: SwappyBlink } })
      .to(tweenTarget, 0.22, {})
      .set(tweenTarget, { attr: { src: SwappyAwake } })
      .to(tweenTarget, 0.7, {})
      .add(props.advance)
  }, [])

  return (
    <div className="py-12 flex justify-center">
      <img
        id="swappy"
        className="opacity-0"
        ref={(e) => (tweenTarget = e)}
        src={SwappySleep}
      />
    </div>
  )
}

export default SwappyAnimation
